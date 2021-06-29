Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75BC73B6BA5
	for <lists+netfilter-devel@lfdr.de>; Tue, 29 Jun 2021 02:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbhF2AUR (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 28 Jun 2021 20:20:17 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:51388 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhF2AUR (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 28 Jun 2021 20:20:17 -0400
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 6EBD1806B6;
        Tue, 29 Jun 2021 12:17:47 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1624925867;
        bh=Z48TLSUaRPjwCOzsFP5jI4CVIWBsOEMPP+SWiySDBKc=;
        h=From:To:Cc:Subject:Date;
        b=S4pgaXR/5zshWU82z751VHRdqTKVYNy7iHdpXWSZLi28i0Gr5IhkAK4+eekea+NLa
         DDDlFFSQ8gzaXlvyzSQH3dOa6TOmigLZnw1C+RuDDywks7ugzcFuFdyRqg2deMslr7
         dmxDanrnFbN4T4qWKnXZmdKlZzy7P+7IGJUNdaFYbLeIi7FNzy2U4PsCEkxtAbXqcY
         3H584FlBToQhxV3iY51uD/kScJGoEVNyetHXMrKpuErskd0TwyhlvoBK+EfF1QfTQa
         vT5QwrRb6gHqxFJfbo9wuLGz4H5cLtNhV7Ptn76v1Yu6WKXiYeDyFCctHHS5wnQyBx
         b21T6hjsqiZ5w==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B60da66ab0000>; Tue, 29 Jun 2021 12:17:47 +1200
Received: from coled-dl.ws.atlnz.lc (coled-dl.ws.atlnz.lc [10.33.25.26])
        by pat.atlnz.lc (Postfix) with ESMTP id 3725513EE58;
        Tue, 29 Jun 2021 12:17:47 +1200 (NZST)
Received: by coled-dl.ws.atlnz.lc (Postfix, from userid 1801)
        id 2F15C242927; Tue, 29 Jun 2021 12:17:47 +1200 (NZST)
From:   Cole Dishington <Cole.Dishington@alliedtelesis.co.nz>
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org,
        Cole Dishington <Cole.Dishington@alliedtelesis.co.nz>
Subject: [PATCH] extensions: masquerade: Add RFC-7597 section 5.1 PSID support
Date:   Tue, 29 Jun 2021 12:16:08 +1200
Message-Id: <20210629001608.30771-1-Cole.Dishington@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=IOh89TnG c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=r6YtysWOX24A:10 a=2OLa6WKVnYtYcIu64U4A:9 a=wYlwU8wnaPom74lq:21 a=otVvmPqgOnAPOBc-:21
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Added --psid option to masquerade extension to specify port ranges, as
described in RFC-7597 section 5.1. The PSID option needs the base field
in range2, so add version 1 of the masquerade extension.

Signed-off-by: Cole Dishington <Cole.Dishington@alliedtelesis.co.nz>
---
 extensions/libipt_MASQUERADE.c   | 283 +++++++++++++++++++++++++------
 include/linux/netfilter/nf_nat.h |   5 +-
 2 files changed, 234 insertions(+), 54 deletions(-)

diff --git a/extensions/libipt_MASQUERADE.c b/extensions/libipt_MASQUERAD=
E.c
index 90bf6065..e4eb6e32 100644
--- a/extensions/libipt_MASQUERADE.c
+++ b/extensions/libipt_MASQUERADE.c
@@ -12,9 +12,41 @@ enum {
 	O_TO_PORTS =3D 0,
 	O_RANDOM,
 	O_RANDOM_FULLY,
+	O_PSID,
 };
=20
-static void MASQUERADE_help(void)
+static unsigned int _log2(unsigned int x)
+{
+	unsigned int y =3D 0;
+
+	for (; x !=3D 1; x >>=3D 1)
+		y++;
+	return y;
+}
+
+static void cpy_ipv4_range_to_range2(struct nf_nat_range2 *dst, const st=
ruct nf_nat_ipv4_range *src)
+{
+	memset(&dst->min_addr, 0, sizeof(dst->min_addr));
+	memset(&dst->max_addr, 0, sizeof(dst->max_addr));
+	memset(&dst->base_proto, 0, sizeof(dst->base_proto));
+
+	dst->flags	 =3D src->flags;
+	dst->min_addr.ip =3D src->min_ip;
+	dst->max_addr.ip =3D src->max_ip;
+	dst->min_proto	 =3D src->min;
+	dst->max_proto	 =3D src->max;
+}
+
+static void cpy_range2_to_ipv4_range(struct nf_nat_ipv4_range *dst, cons=
t struct nf_nat_range2 *src)
+{
+	dst->flags	 =3D src->flags;
+	dst->min_ip =3D src->min_addr.ip;
+	dst->max_ip =3D src->max_addr.ip;
+	dst->min	 =3D src->min_proto;
+	dst->max	 =3D src->max_proto;
+}
+
+static void MASQUERADE_help_v0(void)
 {
 	printf(
 "MASQUERADE target options:\n"
@@ -26,14 +58,36 @@ static void MASQUERADE_help(void)
 "				Fully randomize source port.\n");
 }
=20
-static const struct xt_option_entry MASQUERADE_opts[] =3D {
+static void MASQUERADE_help_v1(void)
+{
+	printf(
+"MASQUERADE target options:\n"
+" --to-ports <port>[-<port>]\n"
+"				Port (range) to map to.\n"
+" --random\n"
+"				Randomize source port.\n"
+" --random-fully\n"
+"				Fully randomize source port.\n"
+" --psid <offset>:<psid>:<psid_length>\n"
+"				Run in PSID mode with this PSID\n");
+}
+
+static const struct xt_option_entry MASQUERADE_opts_v0[] =3D {
+	{.name =3D "to-ports", .id =3D O_TO_PORTS, .type =3D XTTYPE_STRING},
+	{.name =3D "random", .id =3D O_RANDOM, .type =3D XTTYPE_NONE},
+	{.name =3D "random-fully", .id =3D O_RANDOM_FULLY, .type =3D XTTYPE_NON=
E},
+	XTOPT_TABLEEND,
+};
+
+static const struct xt_option_entry MASQUERADE_opts_v1[] =3D {
 	{.name =3D "to-ports", .id =3D O_TO_PORTS, .type =3D XTTYPE_STRING},
 	{.name =3D "random", .id =3D O_RANDOM, .type =3D XTTYPE_NONE},
 	{.name =3D "random-fully", .id =3D O_RANDOM_FULLY, .type =3D XTTYPE_NON=
E},
+	{.name =3D "psid", .id =3D O_PSID, .type =3D XTTYPE_STRING},
 	XTOPT_TABLEEND,
 };
=20
-static void MASQUERADE_init(struct xt_entry_target *t)
+static void MASQUERADE_init_v0(struct xt_entry_target *t)
 {
 	struct nf_nat_ipv4_multi_range_compat *mr =3D (struct nf_nat_ipv4_multi=
_range_compat *)t->data;
=20
@@ -42,21 +96,20 @@ static void MASQUERADE_init(struct xt_entry_target *t=
)
 }
=20
 /* Parses ports */
-static void
-parse_ports(const char *arg, struct nf_nat_ipv4_multi_range_compat *mr)
+static void parse_ports(const char *arg, struct nf_nat_range2 *r)
 {
 	char *end;
 	unsigned int port, maxport;
=20
-	mr->range[0].flags |=3D NF_NAT_RANGE_PROTO_SPECIFIED;
+	r->flags |=3D NF_NAT_RANGE_PROTO_SPECIFIED;
=20
 	if (!xtables_strtoui(arg, &end, &port, 0, UINT16_MAX))
 		xtables_param_act(XTF_BAD_VALUE, "MASQUERADE", "--to-ports", arg);
=20
 	switch (*end) {
 	case '\0':
-		mr->range[0].min.tcp.port
-			=3D mr->range[0].max.tcp.port
+		r->min_proto.tcp.port
+			=3D r->max_proto.tcp.port
 			=3D htons(port);
 		return;
 	case '-':
@@ -66,8 +119,8 @@ parse_ports(const char *arg, struct nf_nat_ipv4_multi_=
range_compat *mr)
 		if (maxport < port)
 			break;
=20
-		mr->range[0].min.tcp.port =3D htons(port);
-		mr->range[0].max.tcp.port =3D htons(maxport);
+		r->min_proto.tcp.port =3D htons(port);
+		r->max_proto.tcp.port =3D htons(maxport);
 		return;
 	default:
 		break;
@@ -75,11 +128,46 @@ parse_ports(const char *arg, struct nf_nat_ipv4_mult=
i_range_compat *mr)
 	xtables_param_act(XTF_BAD_VALUE, "MASQUERADE", "--to-ports", arg);
 }
=20
-static void MASQUERADE_parse(struct xt_option_call *cb)
+static void range_to_psid_args(struct nf_nat_range2 *r, unsigned int *of=
fset,
+			       unsigned int *psid, unsigned int *psid_length)
+{
+	unsigned int min, power_j;
+
+	min =3D htons(r->min_proto.all);
+	power_j =3D htons(r->max_proto.all) - min + 1;
+	*offset =3D ntohs(r->base_proto.all);
+	*psid =3D (min - *offset) >> _log2(power_j);
+	*psid_length =3D _log2(*offset/power_j);
+}
+
+static void parse_psid(const char *arg, struct nf_nat_range2 *r)
+{
+	char *end;
+	unsigned int offset, psid, psid_len;
+
+	if (!xtables_strtoui(arg, &end, &offset, 0, UINT16_MAX) || *end !=3D ':=
' ||
+	    offset >=3D (1 << 16))
+		xtables_param_act(XTF_BAD_VALUE, "MASQUERADE", "PSID settings", arg);
+
+	if (!xtables_strtoui(end + 1, &end, &psid, 0, UINT16_MAX) || *end !=3D =
':')
+		xtables_param_act(XTF_BAD_VALUE, "MASQUERADE", "PSID settings", arg);
+
+	if (!xtables_strtoui(end + 1, &end, &psid_len, 0, UINT16_MAX) || *end !=
=3D '\0' ||
+	    psid_len >=3D 16)
+		xtables_param_act(XTF_BAD_VALUE, "MASQUERADE", "PSID settings", arg);
+
+	psid =3D psid << (_log2(offset/(1 << psid_len)));
+	r->min_proto.all =3D htons(offset + psid);
+	r->max_proto.all =3D htons(offset + psid + ((offset/(1 << psid_len)) - =
1));
+	r->base_proto.all =3D htons(offset);
+	r->flags |=3D NF_NAT_RANGE_PSID;
+	r->flags |=3D NF_NAT_RANGE_PROTO_SPECIFIED;
+}
+
+static void _MASQUERADE_parse(struct xt_option_call *cb, struct nf_nat_r=
ange2 *r, int rev)
 {
 	const struct ipt_entry *entry =3D cb->xt_entry;
 	int portok;
-	struct nf_nat_ipv4_multi_range_compat *mr =3D cb->data;
=20
 	if (entry->ip.proto =3D=3D IPPROTO_TCP
 	    || entry->ip.proto =3D=3D IPPROTO_UDP
@@ -96,29 +184,50 @@ static void MASQUERADE_parse(struct xt_option_call *=
cb)
 		if (!portok)
 			xtables_error(PARAMETER_PROBLEM,
 				   "Need TCP, UDP, SCTP or DCCP with port specification");
-		parse_ports(cb->arg, mr);
+		parse_ports(cb->arg, r);
 		break;
 	case O_RANDOM:
-		mr->range[0].flags |=3D  NF_NAT_RANGE_PROTO_RANDOM;
+		r->flags |=3D  NF_NAT_RANGE_PROTO_RANDOM;
 		break;
 	case O_RANDOM_FULLY:
-		mr->range[0].flags |=3D  NF_NAT_RANGE_PROTO_RANDOM_FULLY;
+		r->flags |=3D  NF_NAT_RANGE_PROTO_RANDOM_FULLY;
+		break;
+	case O_PSID:
+		parse_psid(cb->arg, r);
 		break;
 	}
 }
=20
-static void
-MASQUERADE_print(const void *ip, const struct xt_entry_target *target,
-                 int numeric)
+static void MASQUERADE_parse_v0(struct xt_option_call *cb)
+{
+	struct nf_nat_ipv4_multi_range_compat *mr =3D (void *)cb->data;
+	struct nf_nat_range2 r =3D {};
+
+	cpy_ipv4_range_to_range2(&r, &mr->range[0]);
+	_MASQUERADE_parse(cb, &r, 0);
+	cpy_range2_to_ipv4_range(&mr->range[0], &r);
+}
+
+static void MASQUERADE_parse_v1(struct xt_option_call *cb)
+{
+	_MASQUERADE_parse(cb, (struct nf_nat_range2 *)cb->data, 1);
+}
+
+static void _MASQUERADE_print(const struct nf_nat_range2 *r, int rev)
 {
-	const struct nf_nat_ipv4_multi_range_compat *mr =3D (const void *)targe=
t->data;
-	const struct nf_nat_ipv4_range *r =3D &mr->range[0];
=20
 	if (r->flags & NF_NAT_RANGE_PROTO_SPECIFIED) {
-		printf(" masq ports: ");
-		printf("%hu", ntohs(r->min.tcp.port));
-		if (r->max.tcp.port !=3D r->min.tcp.port)
-			printf("-%hu", ntohs(r->max.tcp.port));
+		if (r->flags & NF_NAT_RANGE_PSID) {
+			unsigned int offset, psid, psid_length;
+
+			range_to_psid_args(r, &offset, &psid, &psid_length);
+			printf(" masq psid: %hu:%hu:%hu", offset, psid, psid_length);
+		} else {
+			printf(" masq ports: ");
+			printf("%hu", ntohs(r->min_proto.tcp.port));
+			if (r->max_proto.tcp.port !=3D r->min_proto.tcp.port)
+				printf("-%hu", ntohs(r->max_proto.tcp.port));
+		}
 	}
=20
 	if (r->flags & NF_NAT_RANGE_PROTO_RANDOM)
@@ -126,18 +235,37 @@ MASQUERADE_print(const void *ip, const struct xt_en=
try_target *target,
=20
 	if (r->flags & NF_NAT_RANGE_PROTO_RANDOM_FULLY)
 		printf(" random-fully");
+
+
 }
=20
-static void
-MASQUERADE_save(const void *ip, const struct xt_entry_target *target)
+static void MASQUERADE_print_v0(const void *ip, const struct xt_entry_ta=
rget *target, int numeric)
 {
 	const struct nf_nat_ipv4_multi_range_compat *mr =3D (const void *)targe=
t->data;
-	const struct nf_nat_ipv4_range *r =3D &mr->range[0];
+	struct nf_nat_range2 r =3D {};
+
+	cpy_ipv4_range_to_range2(&r, &mr->range[0]);
+	_MASQUERADE_print(&r, 0);
+}
+
+static void MASQUERADE_print_v1(const void *ip, const struct xt_entry_ta=
rget *target, int numeric)
+{
+	_MASQUERADE_print((const struct nf_nat_range2 *)target->data, 1);
+}
=20
+static void _MASQUERADE_save(const struct nf_nat_range2 *r, int rev)
+{
 	if (r->flags & NF_NAT_RANGE_PROTO_SPECIFIED) {
-		printf(" --to-ports %hu", ntohs(r->min.tcp.port));
-		if (r->max.tcp.port !=3D r->min.tcp.port)
-			printf("-%hu", ntohs(r->max.tcp.port));
+		if (r->flags & NF_NAT_RANGE_PSID) {
+			unsigned int offset, psid, psid_length;
+
+			range_to_psid_args(r, &offset, &psid, &psid_length);
+			printf(" --psid %hu:%hu:%hu", offset, psid, psid_length);
+		} else {
+			printf(" --to-ports %hu", ntohs(r->min_proto.tcp.port));
+			if (r->max_proto.tcp.port !=3D r->min_proto.tcp.port)
+				printf("-%hu", ntohs(r->max_proto.tcp.port));
+		}
 	}
=20
 	if (r->flags & NF_NAT_RANGE_PROTO_RANDOM)
@@ -147,44 +275,93 @@ MASQUERADE_save(const void *ip, const struct xt_ent=
ry_target *target)
 		printf(" --random-fully");
 }
=20
-static int MASQUERADE_xlate(struct xt_xlate *xl,
-			    const struct xt_xlate_tg_params *params)
+static void MASQUERADE_save_v0(const void *ip, const struct xt_entry_tar=
get *target)
 {
-	const struct nf_nat_ipv4_multi_range_compat *mr =3D
-		(const void *)params->target->data;
-	const struct nf_nat_ipv4_range *r =3D &mr->range[0];
+	const struct nf_nat_ipv4_multi_range_compat *mr =3D (const void *)targe=
t->data;
+	struct nf_nat_range2 r =3D {};
+
+	cpy_ipv4_range_to_range2(&r, &mr->range[0]);
+	_MASQUERADE_save(&r, 0);
+}
+
+static void MASQUERADE_save_v1(const void *ip, const struct xt_entry_tar=
get *target)
+{
+	_MASQUERADE_save((const struct nf_nat_range2 *)target->data, 1);
+}
=20
+static void _MASQUERADE_xlate(struct xt_xlate *xl, const struct nf_nat_r=
ange2 *r, int rev)
+{
 	xt_xlate_add(xl, "masquerade");
=20
 	if (r->flags & NF_NAT_RANGE_PROTO_SPECIFIED) {
-		xt_xlate_add(xl, " to :%hu", ntohs(r->min.tcp.port));
-		if (r->max.tcp.port !=3D r->min.tcp.port)
-			xt_xlate_add(xl, "-%hu", ntohs(r->max.tcp.port));
-        }
+		if (r->flags & NF_NAT_RANGE_PSID) {
+			unsigned int offset, psid, psid_length;
+
+			range_to_psid_args(r, &offset, &psid, &psid_length);
+			xt_xlate_add(xl, " psid %hu:%hu:%hu", offset, psid, psid_length);
+		} else {
+			xt_xlate_add(xl, " to :%hu", ntohs(r->min_proto.tcp.port));
+			if (r->max_proto.tcp.port !=3D r->min_proto.tcp.port)
+				xt_xlate_add(xl, "-%hu", ntohs(r->max_proto.tcp.port));
+		}
+	}
=20
 	xt_xlate_add(xl, " ");
 	if (r->flags & NF_NAT_RANGE_PROTO_RANDOM)
 		xt_xlate_add(xl, "random ");
+}
=20
+static int MASQUERADE_xlate_v0(struct xt_xlate *xl, const struct xt_xlat=
e_tg_params *params)
+{
+	const struct nf_nat_ipv4_multi_range_compat *mr =3D
+		(const void *)params->target->data;
+	struct nf_nat_range2 r =3D {};
+
+	cpy_ipv4_range_to_range2(&r, &mr->range[0]);
+	_MASQUERADE_xlate(xl, &r, 0);
+
+	return 1;
+}
+
+static int MASQUERADE_xlate_v1(struct xt_xlate *xl, const struct xt_xlat=
e_tg_params *params)
+{
+	_MASQUERADE_xlate(xl, (const struct nf_nat_range2 *)params->target->dat=
a, 1);
 	return 1;
 }
=20
-static struct xtables_target masquerade_tg_reg =3D {
-	.name		=3D "MASQUERADE",
-	.version	=3D XTABLES_VERSION,
-	.family		=3D NFPROTO_IPV4,
-	.size		=3D XT_ALIGN(sizeof(struct nf_nat_ipv4_multi_range_compat)),
-	.userspacesize	=3D XT_ALIGN(sizeof(struct nf_nat_ipv4_multi_range_compa=
t)),
-	.help		=3D MASQUERADE_help,
-	.init		=3D MASQUERADE_init,
-	.x6_parse	=3D MASQUERADE_parse,
-	.print		=3D MASQUERADE_print,
-	.save		=3D MASQUERADE_save,
-	.x6_options	=3D MASQUERADE_opts,
-	.xlate		=3D MASQUERADE_xlate,
+static struct xtables_target masquerade_tg_reg[] =3D {
+	{
+		.name		=3D "MASQUERADE",
+		.version	=3D XTABLES_VERSION,
+		.family		=3D NFPROTO_IPV4,
+		.revision	=3D 0,
+		.size		=3D XT_ALIGN(sizeof(struct nf_nat_ipv4_multi_range_compat)),
+		.userspacesize	=3D XT_ALIGN(sizeof(struct nf_nat_ipv4_multi_range_comp=
at)),
+		.help		=3D MASQUERADE_help_v0,
+		.init		=3D MASQUERADE_init_v0,
+		.x6_parse	=3D MASQUERADE_parse_v0,
+		.print		=3D MASQUERADE_print_v0,
+		.save		=3D MASQUERADE_save_v0,
+		.x6_options	=3D MASQUERADE_opts_v0,
+		.xlate		=3D MASQUERADE_xlate_v0,
+	},
+	{
+		.name		=3D "MASQUERADE",
+		.version	=3D XTABLES_VERSION,
+		.family		=3D NFPROTO_IPV4,
+		.revision	=3D 1,
+		.size		=3D XT_ALIGN(sizeof(struct nf_nat_range2)),
+		.userspacesize	=3D XT_ALIGN(sizeof(struct nf_nat_range2)),
+		.help		=3D MASQUERADE_help_v1,
+		.x6_parse	=3D MASQUERADE_parse_v1,
+		.print		=3D MASQUERADE_print_v1,
+		.save		=3D MASQUERADE_save_v1,
+		.x6_options	=3D MASQUERADE_opts_v1,
+		.xlate		=3D MASQUERADE_xlate_v1,
+	},
 };
=20
 void _init(void)
 {
-	xtables_register_target(&masquerade_tg_reg);
+	xtables_register_targets(masquerade_tg_reg, ARRAY_SIZE(masquerade_tg_re=
g));
 }
diff --git a/include/linux/netfilter/nf_nat.h b/include/linux/netfilter/n=
f_nat.h
index b600000d..0f004765 100644
--- a/include/linux/netfilter/nf_nat.h
+++ b/include/linux/netfilter/nf_nat.h
@@ -10,6 +10,8 @@
 #define NF_NAT_RANGE_PERSISTENT			(1 << 3)
 #define NF_NAT_RANGE_PROTO_RANDOM_FULLY		(1 << 4)
 #define NF_NAT_RANGE_PROTO_OFFSET		(1 << 5)
+#define NF_NAT_RANGE_NETMAP			(1 << 6)
+#define NF_NAT_RANGE_PSID			(1 << 7)
=20
 #define NF_NAT_RANGE_PROTO_RANDOM_ALL		\
 	(NF_NAT_RANGE_PROTO_RANDOM | NF_NAT_RANGE_PROTO_RANDOM_FULLY)
@@ -17,7 +19,8 @@
 #define NF_NAT_RANGE_MASK					\
 	(NF_NAT_RANGE_MAP_IPS | NF_NAT_RANGE_PROTO_SPECIFIED |	\
 	 NF_NAT_RANGE_PROTO_RANDOM | NF_NAT_RANGE_PERSISTENT |	\
-	 NF_NAT_RANGE_PROTO_RANDOM_FULLY | NF_NAT_RANGE_PROTO_OFFSET)
+	 NF_NAT_RANGE_PROTO_RANDOM_FULLY | NF_NAT_RANGE_PROTO_OFFSET | \
+	 NF_NAT_RANGE_NETMAP | NF_NAT_RANGE_PSID)
=20
 struct nf_nat_ipv4_range {
 	unsigned int			flags;
--=20
2.32.0

