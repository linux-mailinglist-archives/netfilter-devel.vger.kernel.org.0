Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3234A1C3D
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Aug 2019 16:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfH2OCY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 29 Aug 2019 10:02:24 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:50846 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726283AbfH2OCY (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:02:24 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1i3L0H-0004B1-Fu; Thu, 29 Aug 2019 16:02:21 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     a@juaristi.eus, Florian Westphal <fw@strlen.de>
Subject: [PATCH nft 2/4] meta: Introduce new conditions 'time', 'day' and 'hour'
Date:   Thu, 29 Aug 2019 16:09:02 +0200
Message-Id: <20190829140904.3858-3-fw@strlen.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829140904.3858-1-fw@strlen.de>
References: <20190829140904.3858-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Ander Juaristi <a@juaristi.eus>

These keywords introduce new checks for a timestamp, an absolute date (which is converted to a timestamp),
an hour in the day (which is converted to the number of seconds since midnight) and a day of week.

When converting an ISO date (eg. 2019-06-06 17:00) to a timestamp,
we need to substract it the GMT difference in seconds, that is, the value
of the 'tm_gmtoff' field in the tm structure. This is because the kernel
doesn't know about time zones. And hence the kernel manages different timestamps
than those that are advertised in userspace when running, for instance, date +%s.

The same conversion needs to be done when converting hours (e.g 17:00) to seconds since midnight
as well.

The result needs to be computed modulo 86400 in case GMT offset (difference in seconds from UTC)
is negative.

We also introduce a new command line option (-t, --seconds) to show the actual
timestamps when printing the values, rather than the ISO dates, or the hour.

Some usage examples:

	time < "2019-06-06 17:00" drop;
	time < "2019-06-06 17:20:20" drop;
	time < 12341234 drop;
	day "Saturday" drop;
	day 6 drop;
	hour >= 17:00 drop;
	hour >= "17:00:01" drop;
	hour >= 63000 drop;

We need to convert an ISO date to a timestamp
without taking into account the time zone offset, since comparison will
be done in kernel space and there is no time zone information there.

Overwriting TZ is portable, but will cause problems when parsing a
ruleset that has 'time' and 'hour' rules. Parsing an 'hour' type must
not do time zone conversion, but that will be automatically done if TZ has
been overwritten to UTC.

Hence, we use timegm() to parse the 'time' type, even though it's not portable.
Overwriting TZ seems to be a much worse solution.

Finally, be aware that timestamps are converted to nanoseconds when
transferring to the kernel (as comparison is done with nanosecond
precision), and back to seconds when retrieving them for printing.

We swap left and right values in a range to properly handle
cross-day hour ranges (e.g. 23:15-03:22).

Signed-off-by: Ander Juaristi <a@juaristi.eus>
Reviewed-by: Florian Westphal <fw@strlen.de>
---
 doc/nft.txt                         |   6 +-
 doc/primary-expression.txt          |  27 ++-
 include/datatype.h                  |   6 +
 include/linux/netfilter/nf_tables.h |   6 +
 include/meta.h                      |   3 +
 include/nftables.h                  |   5 +
 include/nftables/libnftables.h      |   1 +
 src/datatype.c                      |   3 +
 src/evaluate.c                      |  54 ++++++
 src/main.c                          |  12 +-
 src/meta.c                          | 261 ++++++++++++++++++++++++++++
 src/parser_bison.y                  |   9 +
 src/scanner.l                       |   1 +
 13 files changed, 390 insertions(+), 4 deletions(-)
 mode change 100755 => 100644 src/evaluate.c

diff --git a/doc/nft.txt b/doc/nft.txt
index 3f1074b8c36e..8a49c2fe97bc 100644
--- a/doc/nft.txt
+++ b/doc/nft.txt
@@ -9,7 +9,7 @@ nft - Administration tool of the nftables framework for packet filtering and cla
 SYNOPSIS
 --------
 [verse]
-*nft* [ *-nNscaeSupyj* ] [ *-I* 'directory' ] [ *-f* 'filename' | *-i* | 'cmd' ...]
+*nft* [ *-nNscaeSupyjt* ] [ *-I* 'directory' ] [ *-f* 'filename' | *-i* | 'cmd' ...]
 *nft* *-h*
 *nft* *-v*
 
@@ -93,6 +93,10 @@ For a full summary of options, run *nft --help*.
 	Read input from an interactive readline CLI. You can use quit to exit, or use the EOF marker,
 	normally this is CTRL-D.
 
+*-t*::
+*--numeric-time*::
+	Show time, day and hour values in numeric format.
+
 INPUT FILE FORMATS
 ------------------
 LEXICAL CONVENTIONS
diff --git a/doc/primary-expression.txt b/doc/primary-expression.txt
index fc17a02cdc48..c5d25eee3c37 100644
--- a/doc/primary-expression.txt
+++ b/doc/primary-expression.txt
@@ -2,7 +2,7 @@ META EXPRESSIONS
 ~~~~~~~~~~~~~~~~
 [verse]
 *meta* {*length* | *nfproto* | *l4proto* | *protocol* | *priority*}
-[*meta*] {*mark* | *iif* | *iifname* | *iiftype* | *oif* | *oifname* | *oiftype* | *skuid* | *skgid* | *nftrace* | *rtclassid* | *ibrname* | *obrname* | *pkttype* | *cpu* | *iifgroup* | *oifgroup* | *cgroup* | *random* | *ipsec* | *iifkind* | *oifkind*}
+[*meta*] {*mark* | *iif* | *iifname* | *iiftype* | *oif* | *oifname* | *oiftype* | *skuid* | *skgid* | *nftrace* | *rtclassid* | *ibrname* | *obrname* | *pkttype* | *cpu* | *iifgroup* | *oifgroup* | *cgroup* | *random* | *ipsec* | *iifkind* | *oifkind* | *time* | *hour* | *day* }
 
 A meta expression refers to meta data associated with a packet.
 
@@ -115,7 +115,16 @@ boolean (1 bit)
 |iifkind|
 Input interface kind |
 |oifkind|
-Output interface kind
+Output interface kind|
+|time|
+Absolute time of packet reception|
+Integer (32 bit) or string
+|day|
+Day of week|
+Integer (8 bit) or string
+|hour|
+Hour of day|
+String
 |====================
 
 .Meta expression specific types
@@ -141,6 +150,20 @@ Packet type: *host* (addressed to local host), *broadcast* (to all),
 *multicast* (to group), *other* (addressed to another host).
 |ifkind|
 Interface kind (16 byte string). Does not have to exist.
+|time|
+Either an integer or a date in ISO format. For example: "2019-06-06 17:00".
+Hour and seconds are optional and can be omitted if desired. If omitted,
+midnight will be assumed.
+The following three would be equivalent: "2019-06-06", "2019-06-06 00:00"
+and "2019-06-06 00:00:00".
+When an integer is given, it is assumed to be a UNIX timestamp.
+|day|
+Either a day of week ("Monday", "Tuesday", etc.), or an integer between 0 and 6.
+Strings are matched case-insensitively, and a full match is not expected (e.g. "Mon" would match "Monday").
+When an integer is given, 0 is Sunday and 6 is Saturday.
+|hour|
+A string representing an hour in 24-hour format. Seconds can optionally be specified.
+For example, 17:00 and 17:00:00 would be equivalent.
 |=============================
 
 .Using meta expressions
diff --git a/include/datatype.h b/include/datatype.h
index c1d08cc29e47..49b8f608aa1d 100644
--- a/include/datatype.h
+++ b/include/datatype.h
@@ -45,6 +45,9 @@
  * @TYPE_DSCP:		Differentiated Services Code Point (integer subtype)
  * @TYPE_IFNAME:	interface name (string subtype)
  * @TYPE_IGMP:		IGMP type (integer subtype)
+ * @TYPE_TIME_DATA	Date type (integer subtype)
+ * @TYPE_TIME_HOUR	Hour type (integer subtype)
+ * @TYPE_TIME_DAY	Day type (integer subtype)
  */
 enum datatypes {
 	TYPE_INVALID,
@@ -90,6 +93,9 @@ enum datatypes {
 	TYPE_CT_EVENTBIT,
 	TYPE_IFNAME,
 	TYPE_IGMP_TYPE,
+	TYPE_TIME_DATE,
+	TYPE_TIME_HOUR,
+	TYPE_TIME_DAY,
 	__TYPE_MAX
 };
 #define TYPE_MAX		(__TYPE_MAX - 1)
diff --git a/include/linux/netfilter/nf_tables.h b/include/linux/netfilter/nf_tables.h
index ec1533990b01..0ff932dadc8e 100644
--- a/include/linux/netfilter/nf_tables.h
+++ b/include/linux/netfilter/nf_tables.h
@@ -800,6 +800,9 @@ enum nft_exthdr_attributes {
  * @NFT_META_OIFKIND: packet output interface kind name (dev->rtnl_link_ops->kind)
  * @NFT_META_BRI_IIFPVID: packet input bridge port pvid
  * @NFT_META_BRI_IIFVPROTO: packet input bridge vlan proto
+ * @NFT_META_TIME_NS: time since epoch (in nanoseconds)
+ * @NFT_META_TIME_DAY: day of week (from 0 = Sunday to 6 = Saturday)
+ * @NFT_META_TIME_HOUR: hour of day (in seconds)
  */
 enum nft_meta_keys {
 	NFT_META_LEN,
@@ -832,6 +835,9 @@ enum nft_meta_keys {
 	NFT_META_OIFKIND,
 	NFT_META_BRI_IIFPVID,
 	NFT_META_BRI_IIFVPROTO,
+	NFT_META_TIME_NS,
+	NFT_META_TIME_DAY,
+	NFT_META_TIME_HOUR,
 };
 
 /**
diff --git a/include/meta.h b/include/meta.h
index 0fe95fd66824..1478902ed141 100644
--- a/include/meta.h
+++ b/include/meta.h
@@ -41,5 +41,8 @@ extern const struct datatype uid_type;
 extern const struct datatype devgroup_type;
 extern const struct datatype pkttype_type;
 extern const struct datatype ifname_type;
+extern const struct datatype date_type;
+extern const struct datatype hour_type;
+extern const struct datatype day_type;
 
 #endif /* NFTABLES_META_H */
diff --git a/include/nftables.h b/include/nftables.h
index ef737c839b2e..1ecf5ef5269c 100644
--- a/include/nftables.h
+++ b/include/nftables.h
@@ -70,6 +70,11 @@ static inline bool nft_output_guid(const struct output_ctx *octx)
 	return octx->flags & NFT_CTX_OUTPUT_GUID;
 }
 
+static inline bool nft_output_seconds(const struct output_ctx *octx)
+{
+	return octx->flags & NFT_CTX_OUTPUT_NUMERIC_TIME;
+}
+
 static inline bool nft_output_numeric_proto(const struct output_ctx *octx)
 {
 	return octx->flags & NFT_CTX_OUTPUT_NUMERIC_PROTO;
diff --git a/include/nftables/libnftables.h b/include/nftables/libnftables.h
index e39c588769e2..7a7a46f3358a 100644
--- a/include/nftables/libnftables.h
+++ b/include/nftables/libnftables.h
@@ -52,6 +52,7 @@ enum {
 	NFT_CTX_OUTPUT_NUMERIC_PROTO	= (1 << 7),
 	NFT_CTX_OUTPUT_NUMERIC_PRIO     = (1 << 8),
 	NFT_CTX_OUTPUT_NUMERIC_SYMBOL	= (1 << 9),
+	NFT_CTX_OUTPUT_NUMERIC_TIME	= (1 << 10),
 	NFT_CTX_OUTPUT_NUMERIC_ALL	= (NFT_CTX_OUTPUT_NUMERIC_PROTO |
 					   NFT_CTX_OUTPUT_NUMERIC_PRIO |
 					   NFT_CTX_OUTPUT_NUMERIC_SYMBOL),
diff --git a/src/datatype.c b/src/datatype.c
index c5a013463eb9..873f7d4d358b 100644
--- a/src/datatype.c
+++ b/src/datatype.c
@@ -71,6 +71,9 @@ static const struct datatype *datatypes[TYPE_MAX + 1] = {
 	[TYPE_BOOLEAN]		= &boolean_type,
 	[TYPE_IFNAME]		= &ifname_type,
 	[TYPE_IGMP_TYPE]	= &igmp_type_type,
+	[TYPE_TIME_DATE]	= &date_type,
+	[TYPE_TIME_HOUR]	= &hour_type,
+	[TYPE_TIME_DAY]		= &day_type,
 };
 
 const struct datatype *datatype_lookup(enum datatypes type)
diff --git a/src/evaluate.c b/src/evaluate.c
old mode 100755
new mode 100644
index a707f5e7e1fb..8d5f5f8014b8
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -1683,14 +1683,68 @@ static int binop_transfer(struct eval_ctx *ctx, struct expr **expr)
 	return 0;
 }
 
+static bool lhs_is_meta_hour(const struct expr *meta)
+{
+	if (meta->etype != EXPR_META)
+		return false;
+
+	return meta->meta.key == NFT_META_TIME_HOUR ||
+	       meta->meta.key == NFT_META_TIME_DAY;
+}
+
+static void swap_values(struct expr *range)
+{
+	struct expr *left_tmp;
+
+	left_tmp = range->left;
+	range->left = range->right;
+	range->right = left_tmp;
+}
+
+static bool range_needs_swap(const struct expr *range)
+{
+	const struct expr *right = range->right;
+	const struct expr *left = range->left;
+
+	return mpz_cmp(left->value, right->value) > 0;
+}
+
 static int expr_evaluate_relational(struct eval_ctx *ctx, struct expr **expr)
 {
 	struct expr *rel = *expr, *left, *right;
+	struct expr *range;
+	int ret;
 
 	if (expr_evaluate(ctx, &rel->left) < 0)
 		return -1;
 	left = rel->left;
 
+	if (rel->right->etype == EXPR_RANGE && lhs_is_meta_hour(rel->left)) {
+		ret = __expr_evaluate_range(ctx, &rel->right);
+		if (ret)
+			return ret;
+
+		range = rel->right;
+
+		/*
+		 * We may need to do this for proper cross-day ranges,
+		 * e.g. meta hour 23:15-03:22
+		 */
+		if (range_needs_swap(range)) {
+			if (ctx->nft->debug_mask & NFT_DEBUG_EVALUATION)
+				nft_print(&ctx->nft->output,
+					  "Inverting range values for cross-day hour matching\n\n");
+
+			if (rel->op == OP_EQ || rel->op == OP_IMPLICIT) {
+				swap_values(range);
+				rel->op = OP_NEQ;
+			} else if (rel->op == OP_NEQ) {
+				swap_values(range);
+				rel->op = OP_EQ;
+			}
+		}
+	}
+
 	if (expr_evaluate(ctx, &rel->right) < 0)
 		return -1;
 	right = rel->right;
diff --git a/src/main.c b/src/main.c
index 9db3d9aa0a15..f77d8a820a02 100644
--- a/src/main.c
+++ b/src/main.c
@@ -42,9 +42,10 @@ enum opt_vals {
 	OPT_GUID		= 'u',
 	OPT_NUMERIC_PRIO	= 'y',
 	OPT_NUMERIC_PROTO	= 'p',
+	OPT_NUMERIC_TIME	= 't',
 	OPT_INVALID		= '?',
 };
-#define OPTSTRING	"hvcf:iI:jvnsNaeSupyp"
+#define OPTSTRING	"hvcf:iI:jvnsNaeSupypt"
 
 static const struct option options[] = {
 	{
@@ -114,6 +115,10 @@ static const struct option options[] = {
 		.name		= "numeric-priority",
 		.val		= OPT_NUMERIC_PRIO,
 	},
+	{
+		.name		= "numeric-time",
+		.val		= OPT_NUMERIC_TIME,
+	},
 	{
 		.name		= NULL
 	}
@@ -140,6 +145,7 @@ static void show_help(const char *name)
 "  -S, --service			Translate ports to service names as described in /etc/services.\n"
 "  -p, --numeric-protocol	Print layer 4 protocols numerically.\n"
 "  -y, --numeric-priority	Print chain priority numerically.\n"
+"  -t, --numeric-time		Print time values numerically.\n"
 "  -a, --handle			Output rule handle.\n"
 "  -e, --echo			Echo what has been added, inserted or replaced.\n"
 "  -I, --includepath <directory>	Add <directory> to the paths searched for include files. Default is: %s\n"
@@ -229,6 +235,7 @@ int main(int argc, char * const *argv)
 			break;
 		case OPT_NUMERIC:
 			output_flags |= NFT_CTX_OUTPUT_NUMERIC_ALL;
+			output_flags |= NFT_CTX_OUTPUT_NUMERIC_TIME;
 			break;
 		case OPT_STATELESS:
 			output_flags |= NFT_CTX_OUTPUT_STATELESS;
@@ -291,6 +298,9 @@ int main(int argc, char * const *argv)
 		case OPT_NUMERIC_PROTO:
 			output_flags |= NFT_CTX_OUTPUT_NUMERIC_PROTO;
 			break;
+		case OPT_NUMERIC_TIME:
+			output_flags |= NFT_CTX_OUTPUT_NUMERIC_TIME;
+			break;
 		case OPT_INVALID:
 			exit(EXIT_FAILURE);
 		}
diff --git a/src/meta.c b/src/meta.c
index 5901c9919ed8..ab73b29e865d 100644
--- a/src/meta.c
+++ b/src/meta.c
@@ -37,6 +37,10 @@
 #include <iface.h>
 #include <json.h>
 
+#define _XOPEN_SOURCE
+#define __USE_XOPEN
+#include <time.h>
+
 static void tchandle_type_print(const struct expr *expr,
 				struct output_ctx *octx)
 {
@@ -375,6 +379,254 @@ const struct datatype ifname_type = {
 	.basetype	= &string_type,
 };
 
+static void date_type_print(const struct expr *expr, struct output_ctx *octx)
+{
+	uint64_t tstamp = mpz_get_uint64(expr->value);
+	struct tm *tm, *cur_tm;
+	char timestr[21];
+
+	/* Convert from nanoseconds to seconds */
+	tstamp /= 1000000000L;
+
+	if (!nft_output_seconds(octx)) {
+		/* Obtain current tm, to add tm_gmtoff to the timestamp */
+		cur_tm = localtime((time_t *) &tstamp);
+
+		if (cur_tm)
+			tstamp += cur_tm->tm_gmtoff;
+
+		if ((tm = gmtime((time_t *) &tstamp)) != NULL &&
+			strftime(timestr, sizeof(timestr) - 1, "%F %T", tm))
+			nft_print(octx, "\"%s\"", timestr);
+		else
+			nft_print(octx, "Error converting timestamp to printed time");
+
+		return;
+	}
+
+	/*
+	 * Do our own printing. The default print function will print in
+	 * nanoseconds, which is ugly.
+	 */
+	nft_print(octx, "%lu", tstamp);
+}
+
+static time_t parse_iso_date(const char *sym)
+{
+	struct tm tm, *cur_tm;
+	time_t ts;
+
+	memset(&tm, 0, sizeof(struct tm));
+
+	if (strptime(sym, "%F %T", &tm))
+		goto success;
+	if (strptime(sym, "%F %R", &tm))
+		goto success;
+	if (strptime(sym, "%F", &tm))
+		goto success;
+
+	return -1;
+
+success:
+	/*
+	 * Overwriting TZ is problematic if we're parsing hour types in this same process,
+	 * hence I'd rather use timegm() which doesn't take into account the TZ env variable,
+	 * even though it's Linux-specific.
+	 */
+	ts = timegm(&tm);
+
+	/* Obtain current tm as well (at the specified time), so that we can substract tm_gmtoff */
+	cur_tm = localtime(&ts);
+
+	if (ts == (time_t) -1 || cur_tm == NULL)
+		return ts;
+
+	/* Substract tm_gmtoff to get the current time */
+	return ts - cur_tm->tm_gmtoff;
+}
+
+static struct error_record *date_type_parse(struct parse_ctx *ctx,
+					    const struct expr *sym,
+					    struct expr **res)
+{
+	const char *endptr = sym->identifier;
+	time_t tstamp;
+
+	if ((tstamp = parse_iso_date(sym->identifier)) != -1)
+		goto success;
+
+	tstamp = strtoul(sym->identifier, (char **) &endptr, 10);
+	if (*endptr == '\0' && endptr != sym->identifier)
+		goto success;
+
+	return error(&sym->location, "Cannot parse date");
+
+success:
+	/* Convert to nanoseconds */
+	tstamp *= 1000000000L;
+	*res = constant_expr_alloc(&sym->location, sym->dtype,
+				   BYTEORDER_HOST_ENDIAN,
+				   sizeof(uint64_t) * BITS_PER_BYTE,
+				   &tstamp);
+	return NULL;
+}
+
+static const struct symbol_table day_type_tbl = {
+	.base		= BASE_DECIMAL,
+	.symbols	= {
+		SYMBOL("Sunday", 0),
+		SYMBOL("Monday", 1),
+		SYMBOL("Tuesday", 2),
+		SYMBOL("Wednesday", 3),
+		SYMBOL("Thursday", 4),
+		SYMBOL("Friday", 5),
+		SYMBOL("Saturday", 6),
+		SYMBOL_LIST_END,
+	},
+};
+
+static void day_type_print(const struct expr *expr, struct output_ctx *octx)
+{
+	return symbolic_constant_print(&day_type_tbl, expr, true, octx);
+}
+
+static void __hour_type_print_r(int hours, int minutes, int seconds, char *out, size_t buflen)
+{
+	if (minutes == 60)
+		return __hour_type_print_r(++hours, 0, seconds, out, buflen);
+	else if (minutes > 60)
+		return __hour_type_print_r((int) (minutes / 60), minutes % 60, seconds, out, buflen);
+
+	if (seconds == 60)
+		return __hour_type_print_r(hours, ++minutes, 0, out, buflen);
+	else if (seconds > 60)
+		return __hour_type_print_r(hours, (int) (seconds / 60), seconds % 60, out, buflen);
+
+	if (seconds == 0)
+		snprintf(out, buflen, "%02d:%02d", hours, minutes);
+	else
+		snprintf(out, buflen, "%02d:%02d:%02d", hours, minutes, seconds);
+}
+
+static void hour_type_print(const struct expr *expr, struct output_ctx *octx)
+{
+	uint32_t seconds = mpz_get_uint32(expr->value);
+	struct tm *cur_tm;
+	char out[32];
+	time_t ts;
+
+	if (!nft_output_seconds(octx)) {
+		/* Obtain current tm, so that we can add tm_gmtoff */
+		ts = time(NULL);
+		cur_tm = localtime(&ts);
+
+		if (cur_tm)
+			seconds = (seconds + cur_tm->tm_gmtoff) % 86400;
+
+		__hour_type_print_r(0, 0, seconds, out, sizeof(out));
+		nft_print(octx, "\"%s\"", out);
+
+		return;
+	}
+
+	expr_basetype(expr)->print(expr, octx);
+}
+
+static struct error_record *hour_type_parse(struct parse_ctx *ctx,
+					    const struct expr *sym,
+					    struct expr **res)
+{
+	struct error_record *er;
+	struct tm tm, *cur_tm;
+	uint64_t result = 0;
+	char *endptr;
+	time_t ts;
+
+	memset(&tm, 0, sizeof(struct tm));
+
+	/* First, try to parse it as a number */
+	result = strtoul(sym->identifier, (char **) &endptr, 10);
+	if (*endptr == '\0' && endptr != sym->identifier)
+		goto success;
+
+	result = 0;
+
+	/* Obtain current tm, so that we can substract tm_gmtoff */
+	ts = time(NULL);
+	cur_tm = localtime(&ts);
+
+	endptr = strptime(sym->identifier, "%T", &tm);
+	if (endptr && *endptr == '\0')
+		goto convert;
+
+	endptr = strptime(sym->identifier, "%R", &tm);
+	if (endptr && *endptr == '\0')
+		goto convert;
+
+	if (endptr && *endptr)
+		return error(&sym->location, "Can't parse trailing input: \"%s\"\n", endptr);
+
+	if ((er = time_parse(&sym->location, sym->identifier, &result)) == NULL) {
+		result /= 1000;
+		goto convert;
+	}
+
+	return er;
+
+convert:
+	/* Convert the hour to the number of seconds since midnight */
+	if (result == 0)
+		result = tm.tm_hour * 3600 + tm.tm_min * 60 + tm.tm_sec;
+
+	/* Substract tm_gmtoff to get the current time */
+	if (cur_tm) {
+		if ((long int) result >= cur_tm->tm_gmtoff)
+			result = (result - cur_tm->tm_gmtoff) % 86400;
+		else
+			result = 86400 - cur_tm->tm_gmtoff + result;
+	}
+
+success:
+	*res = constant_expr_alloc(&sym->location, sym->dtype,
+				   BYTEORDER_HOST_ENDIAN,
+				   sizeof(uint32_t) * BITS_PER_BYTE,
+				   &result);
+	return NULL;
+}
+
+const struct datatype date_type = {
+	.type = TYPE_TIME_DATE,
+	.name = "time",
+	.desc = "Relative time of packet reception",
+	.byteorder = BYTEORDER_HOST_ENDIAN,
+	.size = sizeof(uint64_t) * BITS_PER_BYTE,
+	.basetype = &integer_type,
+	.print = date_type_print,
+	.parse = date_type_parse,
+};
+
+const struct datatype day_type = {
+	.type = TYPE_TIME_DAY,
+	.name = "day",
+	.desc = "Day of week of packet reception",
+	.byteorder = BYTEORDER_HOST_ENDIAN,
+	.size = 1 * BITS_PER_BYTE,
+	.basetype = &integer_type,
+	.print = day_type_print,
+	.sym_tbl = &day_type_tbl,
+};
+
+const struct datatype hour_type = {
+	.type = TYPE_TIME_HOUR,
+	.name = "hour",
+	.desc = "Hour of day of packet reception",
+	.byteorder = BYTEORDER_HOST_ENDIAN,
+	.size = sizeof(uint64_t) * BITS_PER_BYTE,
+	.basetype = &integer_type,
+	.print = hour_type_print,
+	.parse = hour_type_parse,
+};
+
 const struct meta_template meta_templates[] = {
 	[NFT_META_LEN]		= META_TEMPLATE("length",    &integer_type,
 						4 * 8, BYTEORDER_HOST_ENDIAN),
@@ -442,6 +694,15 @@ const struct meta_template meta_templates[] = {
 	[NFT_META_OIFKIND]	= META_TEMPLATE("oifkind",   &ifname_type,
 						IFNAMSIZ * BITS_PER_BYTE,
 						BYTEORDER_HOST_ENDIAN),
+	[NFT_META_TIME_NS]	= META_TEMPLATE("time",   &date_type,
+						8 * BITS_PER_BYTE,
+						BYTEORDER_HOST_ENDIAN),
+	[NFT_META_TIME_DAY]	= META_TEMPLATE("day", &day_type,
+						1 * BITS_PER_BYTE,
+						BYTEORDER_HOST_ENDIAN),
+	[NFT_META_TIME_HOUR]	= META_TEMPLATE("hour", &hour_type,
+						4 * BITS_PER_BYTE,
+						BYTEORDER_HOST_ENDIAN),
 };
 
 static bool meta_key_is_unqualified(enum nft_meta_keys key)
diff --git a/src/parser_bison.y b/src/parser_bison.y
index 5fb3a60ab5cf..b7db1a21845b 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -431,6 +431,7 @@ int nft_lex(void *, void *, void *);
 %token IIFGROUP			"iifgroup"
 %token OIFGROUP			"oifgroup"
 %token CGROUP			"cgroup"
+%token TIME			"time"
 
 %token CLASSID			"classid"
 %token NEXTHOP			"nexthop"
@@ -1827,6 +1828,11 @@ data_type_atom_expr	:	type_identifier
 							 dtype->size, NULL);
 				xfree($1);
 			}
+			|	TIME
+			{
+				$$ = constant_expr_alloc(&@1, &time_type, time_type.byteorder,
+							 time_type.size, NULL);
+			}
 			;
 
 data_type_expr		:	data_type_atom_expr
@@ -4050,6 +4056,9 @@ meta_key_unqualified	:	MARK		{ $$ = NFT_META_MARK; }
 			|       OIFGROUP	{ $$ = NFT_META_OIFGROUP; }
 			|       CGROUP		{ $$ = NFT_META_CGROUP; }
 			|       IPSEC		{ $$ = NFT_META_SECPATH; }
+			|       TIME		{ $$ = NFT_META_TIME_NS; }
+			|       DAY		{ $$ = NFT_META_TIME_DAY; }
+			|       HOUR		{ $$ = NFT_META_TIME_HOUR; }
 			;
 
 meta_stmt		:	META	meta_key	SET	stmt_expr
diff --git a/src/scanner.l b/src/scanner.l
index c1adcbddbd73..fdf84ba7820e 100644
--- a/src/scanner.l
+++ b/src/scanner.l
@@ -426,6 +426,7 @@ addrstring	({macaddr}|{ip4addr}|{ip6addr})
 "sack3"			{ return SACK3; }
 "sack-permitted"	{ return SACK_PERMITTED; }
 "timestamp"		{ return TIMESTAMP; }
+"time"			{ return TIME; }
 
 "kind"			{ return KIND; }
 "count"			{ return COUNT; }
-- 
2.21.0

