Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67604EC8FB
	for <lists+netfilter-devel@lfdr.de>; Wed, 30 Mar 2022 17:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348356AbiC3QAx (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 30 Mar 2022 12:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238058AbiC3QAv (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:00:51 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C895823154
        for <netfilter-devel@vger.kernel.org>; Wed, 30 Mar 2022 08:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
        s=mail2022; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=rTD/8RWxLcOWafBzeaJwupkInXvfTjOXHz9fvbIpDO0=; b=iaAHpVFDYEL/Ym8xg3CGMarlcq
        UE7PW/jkQPWd2CZv0yqfN09w8pEjva10ObsUMVJG5czrAO9OceYY3il3uk4I7zgi6dzbm0WgKuhGB
        /xkqpTom5WTiLPrQPnTatnylR8AMeX+7TSy3w3hBDRPnXUV4ElvYowYHN616isNxQka9VxjDBB9Cm
        SPyOOXhE+gb4VzIODbXz14QprnuiJXpfZjBK7LCFBAsixUMVFpez3aEpzYsxSgRxzQ7vbsHNjIIql
        q7sjWVs4+GSBsJDa1hLXR78A6YJxs+81qDkgRyDA0LIwSavHZLQ/TZzj2KvecJ1vRNRdm7i0FgiVx
        /E6VSVgg==;
Received: from localhost ([::1] helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1nZaiu-0004XC-6F; Wed, 30 Mar 2022 17:59:04 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 3/9] extensions: ipt_DNAT: Merge v1 and v2 parsers
Date:   Wed, 30 Mar 2022 17:58:45 +0200
Message-Id: <20220330155851.13249-4-phil@nwl.cc>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220330155851.13249-1-phil@nwl.cc>
References: <20220330155851.13249-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Use v2 parser for both and copy field values into v1 data structure if
needed.

While being at it:

* Introduce parse_ports() function similar to the one in
  libipt_REDIRECT.c.
* Use xtables_strtoui() in the above instead of atoi() for integrated
  range checking.
* Parse IP addresses using inet_pton(), writing directly into
  struct nf_nat_range2 fields.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 extensions/libipt_DNAT.c | 290 +++++++++++++++------------------------
 1 file changed, 111 insertions(+), 179 deletions(-)

diff --git a/extensions/libipt_DNAT.c b/extensions/libipt_DNAT.c
index e93ab6958969b..2a7b1bc4ec0a6 100644
--- a/extensions/libipt_DNAT.c
+++ b/extensions/libipt_DNAT.c
@@ -5,6 +5,7 @@
 #include <xtables.h>
 #include <iptables.h> /* get_kernel_version */
 #include <limits.h> /* INT_MAX in ip_tables.h */
+#include <arpa/inet.h>
 #include <linux/netfilter_ipv4/ip_tables.h>
 #include <linux/netfilter/nf_nat.h>
 
@@ -42,54 +43,83 @@ static const struct xt_option_entry DNAT_opts[] = {
 	XTOPT_TABLEEND,
 };
 
+/* Parses ports */
+static void
+parse_ports(const char *arg, bool portok, struct nf_nat_range2 *range)
+{
+	unsigned int port, maxport, baseport;
+	char *end = NULL;
+
+	if (!portok)
+		xtables_error(PARAMETER_PROBLEM,
+			      "Need TCP, UDP, SCTP or DCCP with port specification");
+
+	range->flags |= NF_NAT_RANGE_PROTO_SPECIFIED;
+
+	if (!xtables_strtoui(arg, &end, &port, 1, UINT16_MAX))
+		xtables_error(PARAMETER_PROBLEM,
+			      "Port `%s' not valid", arg);
+
+	switch (*end) {
+	case '\0':
+		range->min_proto.tcp.port
+			= range->max_proto.tcp.port
+			= htons(port);
+		return;
+	case '-':
+		arg = end + 1;
+		break;
+	case ':':
+		xtables_error(PARAMETER_PROBLEM,
+			      "Invalid port:port syntax - use dash");
+	default:
+		xtables_error(PARAMETER_PROBLEM,
+			      "Garbage after port value: `%s'", end);
+	}
+
+	if (!xtables_strtoui(arg, &end, &maxport, 1, UINT16_MAX))
+		xtables_error(PARAMETER_PROBLEM,
+			      "Port `%s' not valid", arg);
+
+	if (maxport < port)
+		/* People are stupid. */
+		xtables_error(PARAMETER_PROBLEM,
+			   "Port range `%s' funky", arg);
+
+	range->min_proto.tcp.port = htons(port);
+	range->max_proto.tcp.port = htons(maxport);
+
+	switch (*end) {
+	case '\0':
+		return;
+	case '/':
+		arg = end + 1;
+		break;
+	default:
+		xtables_error(PARAMETER_PROBLEM,
+			      "Garbage after port range: `%s'", end);
+	}
+
+	if (!xtables_strtoui(arg, &end, &baseport, 1, UINT16_MAX))
+		xtables_error(PARAMETER_PROBLEM,
+			      "Port `%s' not valid", arg);
+
+	range->flags |= NF_NAT_RANGE_PROTO_OFFSET;
+	range->base_proto.tcp.port = htons(baseport);
+}
+
 /* Ranges expected in network order. */
 static void
-parse_to(const char *orig_arg, int portok, struct nf_nat_ipv4_range *range)
+parse_to(const char *orig_arg, bool portok, struct nf_nat_range2 *range)
 {
-	char *arg, *colon, *dash, *error;
-	const struct in_addr *ip;
+	char *arg, *colon, *dash;
 
 	arg = xtables_strdup(orig_arg);
 	colon = strchr(arg, ':');
 
 	if (colon) {
-		int port;
-
-		if (!portok)
-			xtables_error(PARAMETER_PROBLEM,
-				   "Need TCP, UDP, SCTP or DCCP with port specification");
-
-		range->flags |= NF_NAT_RANGE_PROTO_SPECIFIED;
+		parse_ports(colon + 1, portok, range);
 
-		port = atoi(colon+1);
-		if (port <= 0 || port > 65535)
-			xtables_error(PARAMETER_PROBLEM,
-				   "Port `%s' not valid\n", colon+1);
-
-		error = strchr(colon+1, ':');
-		if (error)
-			xtables_error(PARAMETER_PROBLEM,
-				   "Invalid port:port syntax - use dash\n");
-
-		dash = strchr(colon, '-');
-		if (!dash) {
-			range->min.tcp.port
-				= range->max.tcp.port
-				= htons(port);
-		} else {
-			int maxport;
-
-			maxport = atoi(dash + 1);
-			if (maxport <= 0 || maxport > 65535)
-				xtables_error(PARAMETER_PROBLEM,
-					   "Port `%s' not valid\n", dash+1);
-			if (maxport < port)
-				/* People are stupid. */
-				xtables_error(PARAMETER_PROBLEM,
-					   "Port range `%s' funky\n", colon+1);
-			range->min.tcp.port = htons(port);
-			range->max.tcp.port = htons(maxport);
-		}
 		/* Starts with a colon? No IP info...*/
 		if (colon == arg) {
 			free(arg);
@@ -106,46 +136,57 @@ parse_to(const char *orig_arg, int portok, struct nf_nat_ipv4_range *range)
 	if (dash)
 		*dash = '\0';
 
-	ip = xtables_numeric_to_ipaddr(arg);
-	if (!ip)
-		xtables_error(PARAMETER_PROBLEM, "Bad IP address \"%s\"\n",
-			   arg);
-	range->min_ip = ip->s_addr;
+	if (!inet_pton(AF_INET, arg, &range->min_addr))
+		xtables_error(PARAMETER_PROBLEM,
+			      "Bad IP address \"%s\"\n", arg);
 	if (dash) {
-		ip = xtables_numeric_to_ipaddr(dash+1);
-		if (!ip)
-			xtables_error(PARAMETER_PROBLEM, "Bad IP address \"%s\"\n",
-				   dash+1);
-		range->max_ip = ip->s_addr;
-	} else
-		range->max_ip = range->min_ip;
-
+		if (!inet_pton(AF_INET, dash + 1, &range->max_addr))
+			xtables_error(PARAMETER_PROBLEM,
+				      "Bad IP address \"%s\"\n", dash + 1);
+	} else {
+		range->max_addr = range->min_addr;
+	}
 	free(arg);
 	return;
 }
 
+static void __DNAT_parse(struct xt_option_call *cb, __u16 proto,
+			 struct nf_nat_range2 *range)
+{
+	bool portok = proto == IPPROTO_TCP ||
+		      proto == IPPROTO_UDP ||
+		      proto == IPPROTO_SCTP ||
+		      proto == IPPROTO_DCCP ||
+		      proto == IPPROTO_ICMP;
+
+	xtables_option_parse(cb);
+	switch (cb->entry->id) {
+	case O_TO_DEST:
+		parse_to(cb->arg, portok, range);
+		break;
+	case O_PERSISTENT:
+		range->flags |= NF_NAT_RANGE_PERSISTENT;
+		break;
+	}
+}
+
 static void DNAT_parse(struct xt_option_call *cb)
 {
 	struct nf_nat_ipv4_multi_range_compat *mr = (void *)cb->data;
 	const struct ipt_entry *entry = cb->xt_entry;
-	int portok;
+	struct nf_nat_range2 range = {};
 
-	if (entry->ip.proto == IPPROTO_TCP
-	    || entry->ip.proto == IPPROTO_UDP
-	    || entry->ip.proto == IPPROTO_SCTP
-	    || entry->ip.proto == IPPROTO_DCCP
-	    || entry->ip.proto == IPPROTO_ICMP)
-		portok = 1;
-	else
-		portok = 0;
+	__DNAT_parse(cb, entry->ip.proto, &range);
 
-	xtables_option_parse(cb);
 	switch (cb->entry->id) {
 	case O_TO_DEST:
-		parse_to(cb->arg, portok, mr->range);
-		break;
+		mr->range->min_ip = range.min_addr.ip;
+		mr->range->max_ip = range.max_addr.ip;
+		mr->range->min = range.min_proto;
+		mr->range->max = range.max_proto;
+		/* fall through */
 	case O_PERSISTENT:
-		mr->range->flags |= NF_NAT_RANGE_PERSISTENT;
+		mr->range->flags |= range.flags;
 		break;
 	}
 }
@@ -159,6 +200,10 @@ static void DNAT_fcheck(struct xt_fcheck_call *cb)
 		mr->range[0].flags |= NF_NAT_RANGE_PROTO_RANDOM;
 
 	mr->rangesize = 1;
+
+	if (mr->range[0].flags & NF_NAT_RANGE_PROTO_OFFSET)
+		xtables_error(PARAMETER_PROBLEM,
+			      "Shifted portmap ranges not supported with this kernel");
 }
 
 static void print_range(const struct nf_nat_ipv4_range *r)
@@ -251,124 +296,11 @@ static int DNAT_xlate(struct xt_xlate *xl,
 	return 1;
 }
 
-static void
-parse_to_v2(const char *orig_arg, int portok, struct nf_nat_range2 *range)
-{
-	char *arg, *colon, *dash, *error;
-	const struct in_addr *ip;
-
-	arg = xtables_strdup(orig_arg);
-
-	colon = strchr(arg, ':');
-	if (colon) {
-		int port;
-
-		if (!portok)
-			xtables_error(PARAMETER_PROBLEM,
-				   "Need TCP, UDP, SCTP or DCCP with port specification");
-
-		range->flags |= NF_NAT_RANGE_PROTO_SPECIFIED;
-
-		port = atoi(colon+1);
-		if (port <= 0 || port > 65535)
-			xtables_error(PARAMETER_PROBLEM,
-				   "Port `%s' not valid\n", colon+1);
-
-		error = strchr(colon+1, ':');
-		if (error)
-			xtables_error(PARAMETER_PROBLEM,
-				   "Invalid port:port syntax - use dash\n");
-
-		dash = strchr(colon, '-');
-		if (!dash) {
-			range->min_proto.tcp.port
-				= range->max_proto.tcp.port
-				= htons(port);
-		} else {
-			int maxport;
-			char *slash;
-
-			maxport = atoi(dash + 1);
-			if (maxport <= 0 || maxport > 65535)
-				xtables_error(PARAMETER_PROBLEM,
-					   "Port `%s' not valid\n", dash+1);
-			if (maxport < port)
-				/* People are stupid. */
-				xtables_error(PARAMETER_PROBLEM,
-					   "Port range `%s' funky\n", colon+1);
-			range->min_proto.tcp.port = htons(port);
-			range->max_proto.tcp.port = htons(maxport);
-
-			slash = strchr(dash, '/');
-			if (slash) {
-				int baseport;
-
-				baseport = atoi(slash + 1);
-				if (baseport <= 0 || baseport > 65535)
-					xtables_error(PARAMETER_PROBLEM,
-							 "Port `%s' not valid\n", slash+1);
-				range->flags |= NF_NAT_RANGE_PROTO_OFFSET;
-				range->base_proto.tcp.port = htons(baseport);
-			}
-		}
-		/* Starts with a colon? No IP info...*/
-		if (colon == arg) {
-			free(arg);
-			return;
-		}
-		*colon = '\0';
-	}
-
-	range->flags |= NF_NAT_RANGE_MAP_IPS;
-	dash = strchr(arg, '-');
-	if (colon && dash && dash > colon)
-		dash = NULL;
-
-	if (dash)
-		*dash = '\0';
-
-	ip = xtables_numeric_to_ipaddr(arg);
-	if (!ip)
-		xtables_error(PARAMETER_PROBLEM, "Bad IP address \"%s\"\n",
-			   arg);
-	range->min_addr.in = *ip;
-	if (dash) {
-		ip = xtables_numeric_to_ipaddr(dash+1);
-		if (!ip)
-			xtables_error(PARAMETER_PROBLEM, "Bad IP address \"%s\"\n",
-				   dash+1);
-		range->max_addr.in = *ip;
-	} else
-		range->max_addr = range->min_addr;
-
-	free(arg);
-	return;
-}
-
 static void DNAT_parse_v2(struct xt_option_call *cb)
 {
 	const struct ipt_entry *entry = cb->xt_entry;
-	struct nf_nat_range2 *range = cb->data;
-	int portok;
-
-	if (entry->ip.proto == IPPROTO_TCP
-	    || entry->ip.proto == IPPROTO_UDP
-	    || entry->ip.proto == IPPROTO_SCTP
-	    || entry->ip.proto == IPPROTO_DCCP
-	    || entry->ip.proto == IPPROTO_ICMP)
-		portok = 1;
-	else
-		portok = 0;
 
-	xtables_option_parse(cb);
-	switch (cb->entry->id) {
-	case O_TO_DEST:
-		parse_to_v2(cb->arg, portok, range);
-		break;
-	case O_PERSISTENT:
-		range->flags |= NF_NAT_RANGE_PERSISTENT;
-		break;
-	}
+	__DNAT_parse(cb, entry->ip.proto, cb->data);
 }
 
 static void DNAT_fcheck_v2(struct xt_fcheck_call *cb)
-- 
2.34.1

