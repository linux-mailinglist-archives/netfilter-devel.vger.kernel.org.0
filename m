Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABB9553027
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Jun 2022 12:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347505AbiFUKvb (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 21 Jun 2022 06:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347789AbiFUKvZ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 21 Jun 2022 06:51:25 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02E0E027
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Jun 2022 03:51:21 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1o3bTc-0002bm-Cw; Tue, 21 Jun 2022 12:51:20 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 3/3] netfilter: h323: merge nat hook pointers into one
Date:   Tue, 21 Jun 2022 12:50:57 +0200
Message-Id: <20220621105057.24394-4-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621105057.24394-1-fw@strlen.de>
References: <20220621105057.24394-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

sparse complains about incorrect rcu usage.

Code uses the correct rcu access primitives, but the function pointers
lack rcu annotations.

Collapse all of them into a single structure, then annotate the pointer.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/linux/netfilter/nf_conntrack_h323.h | 109 ++++----
 net/ipv4/netfilter/nf_nat_h323.c            |  42 ++--
 net/netfilter/nf_conntrack_h323_main.c      | 259 ++++++++------------
 3 files changed, 168 insertions(+), 242 deletions(-)

diff --git a/include/linux/netfilter/nf_conntrack_h323.h b/include/linux/netfilter/nf_conntrack_h323.h
index 4561ec0fcea4..9e937f64a1ad 100644
--- a/include/linux/netfilter/nf_conntrack_h323.h
+++ b/include/linux/netfilter/nf_conntrack_h323.h
@@ -38,60 +38,63 @@ void nf_conntrack_h245_expect(struct nf_conn *new,
 			      struct nf_conntrack_expect *this);
 void nf_conntrack_q931_expect(struct nf_conn *new,
 			      struct nf_conntrack_expect *this);
-extern int (*set_h245_addr_hook) (struct sk_buff *skb, unsigned int protoff,
-				  unsigned char **data, int dataoff,
-				  H245_TransportAddress *taddr,
-				  union nf_inet_addr *addr,
-				  __be16 port);
-extern int (*set_h225_addr_hook) (struct sk_buff *skb, unsigned int protoff,
-				  unsigned char **data, int dataoff,
-				  TransportAddress *taddr,
-				  union nf_inet_addr *addr,
-				  __be16 port);
-extern int (*set_sig_addr_hook) (struct sk_buff *skb,
-				 struct nf_conn *ct,
-				 enum ip_conntrack_info ctinfo,
-				 unsigned int protoff, unsigned char **data,
-				 TransportAddress *taddr, int count);
-extern int (*set_ras_addr_hook) (struct sk_buff *skb,
-				 struct nf_conn *ct,
-				 enum ip_conntrack_info ctinfo,
-				 unsigned int protoff, unsigned char **data,
-				 TransportAddress *taddr, int count);
-extern int (*nat_rtp_rtcp_hook) (struct sk_buff *skb,
-				 struct nf_conn *ct,
-				 enum ip_conntrack_info ctinfo,
-				 unsigned int protoff, unsigned char **data,
-				 int dataoff,
-				 H245_TransportAddress *taddr,
-				 __be16 port, __be16 rtp_port,
-				 struct nf_conntrack_expect *rtp_exp,
-				 struct nf_conntrack_expect *rtcp_exp);
-extern int (*nat_t120_hook) (struct sk_buff *skb, struct nf_conn *ct,
-			     enum ip_conntrack_info ctinfo,
-			     unsigned int protoff,
+
+struct nfct_h323_nat_hooks {
+	int (*set_h245_addr)(struct sk_buff *skb, unsigned int protoff,
 			     unsigned char **data, int dataoff,
-			     H245_TransportAddress *taddr, __be16 port,
-			     struct nf_conntrack_expect *exp);
-extern int (*nat_h245_hook) (struct sk_buff *skb, struct nf_conn *ct,
-			     enum ip_conntrack_info ctinfo,
-			     unsigned int protoff,
+			     H245_TransportAddress *taddr,
+			     union nf_inet_addr *addr, __be16 port);
+	int (*set_h225_addr)(struct sk_buff *skb, unsigned int protoff,
 			     unsigned char **data, int dataoff,
-			     TransportAddress *taddr, __be16 port,
-			     struct nf_conntrack_expect *exp);
-extern int (*nat_callforwarding_hook) (struct sk_buff *skb,
-				       struct nf_conn *ct,
-				       enum ip_conntrack_info ctinfo,
-				       unsigned int protoff,
-				       unsigned char **data, int dataoff,
-				       TransportAddress *taddr,
-				       __be16 port,
-				       struct nf_conntrack_expect *exp);
-extern int (*nat_q931_hook) (struct sk_buff *skb, struct nf_conn *ct,
-			     enum ip_conntrack_info ctinfo,
-			     unsigned int protoff,
-			     unsigned char **data, TransportAddress *taddr,
-			     int idx, __be16 port,
-			     struct nf_conntrack_expect *exp);
+			     TransportAddress *taddr,
+			     union nf_inet_addr *addr, __be16 port);
+	int (*set_sig_addr)(struct sk_buff *skb,
+			    struct nf_conn *ct,
+			    enum ip_conntrack_info ctinfo,
+			    unsigned int protoff, unsigned char **data,
+			    TransportAddress *taddr, int count);
+	int (*set_ras_addr)(struct sk_buff *skb,
+			    struct nf_conn *ct,
+			    enum ip_conntrack_info ctinfo,
+			    unsigned int protoff, unsigned char **data,
+			    TransportAddress *taddr, int count);
+	int (*nat_rtp_rtcp)(struct sk_buff *skb,
+			    struct nf_conn *ct,
+			    enum ip_conntrack_info ctinfo,
+			    unsigned int protoff,
+			    unsigned char **data, int dataoff,
+			    H245_TransportAddress *taddr,
+			    __be16 port, __be16 rtp_port,
+			    struct nf_conntrack_expect *rtp_exp,
+			    struct nf_conntrack_expect *rtcp_exp);
+	int (*nat_t120)(struct sk_buff *skb,
+			struct nf_conn *ct,
+			enum ip_conntrack_info ctinfo,
+			unsigned int protoff,
+			unsigned char **data, int dataoff,
+			H245_TransportAddress *taddr, __be16 port,
+			struct nf_conntrack_expect *exp);
+	int (*nat_h245)(struct sk_buff *skb,
+			struct nf_conn *ct,
+			enum ip_conntrack_info ctinfo,
+			unsigned int protoff,
+			unsigned char **data, int dataoff,
+			TransportAddress *taddr, __be16 port,
+			struct nf_conntrack_expect *exp);
+	int (*nat_callforwarding)(struct sk_buff *skb,
+				  struct nf_conn *ct,
+				  enum ip_conntrack_info ctinfo,
+				  unsigned int protoff,
+				  unsigned char **data, int dataoff,
+				  TransportAddress *taddr, __be16 port,
+				  struct nf_conntrack_expect *exp);
+	int (*nat_q931)(struct sk_buff *skb,
+			struct nf_conn *ct,
+			enum ip_conntrack_info ctinfo,
+			unsigned int protoff,
+			unsigned char **data, TransportAddress *taddr, int idx,
+			__be16 port, struct nf_conntrack_expect *exp);
+};
+extern const struct nfct_h323_nat_hooks __rcu *nfct_h323_nat_hook;
 
 #endif
diff --git a/net/ipv4/netfilter/nf_nat_h323.c b/net/ipv4/netfilter/nf_nat_h323.c
index 76a411ae9fe6..a334f0dcc2d0 100644
--- a/net/ipv4/netfilter/nf_nat_h323.c
+++ b/net/ipv4/netfilter/nf_nat_h323.c
@@ -579,28 +579,22 @@ static struct nf_ct_helper_expectfn callforwarding_nat = {
 	.expectfn	= ip_nat_callforwarding_expect,
 };
 
+static const struct nfct_h323_nat_hooks nathooks = {
+	.set_h245_addr = set_h245_addr,
+	.set_h225_addr = set_h225_addr,
+	.set_sig_addr = set_sig_addr,
+	.set_ras_addr = set_ras_addr,
+	.nat_rtp_rtcp = nat_rtp_rtcp,
+	.nat_t120 = nat_t120,
+	.nat_h245 = nat_h245,
+	.nat_callforwarding = nat_callforwarding,
+	.nat_q931 = nat_q931,
+};
+
 /****************************************************************************/
 static int __init nf_nat_h323_init(void)
 {
-	BUG_ON(set_h245_addr_hook != NULL);
-	BUG_ON(set_h225_addr_hook != NULL);
-	BUG_ON(set_sig_addr_hook != NULL);
-	BUG_ON(set_ras_addr_hook != NULL);
-	BUG_ON(nat_rtp_rtcp_hook != NULL);
-	BUG_ON(nat_t120_hook != NULL);
-	BUG_ON(nat_h245_hook != NULL);
-	BUG_ON(nat_callforwarding_hook != NULL);
-	BUG_ON(nat_q931_hook != NULL);
-
-	RCU_INIT_POINTER(set_h245_addr_hook, set_h245_addr);
-	RCU_INIT_POINTER(set_h225_addr_hook, set_h225_addr);
-	RCU_INIT_POINTER(set_sig_addr_hook, set_sig_addr);
-	RCU_INIT_POINTER(set_ras_addr_hook, set_ras_addr);
-	RCU_INIT_POINTER(nat_rtp_rtcp_hook, nat_rtp_rtcp);
-	RCU_INIT_POINTER(nat_t120_hook, nat_t120);
-	RCU_INIT_POINTER(nat_h245_hook, nat_h245);
-	RCU_INIT_POINTER(nat_callforwarding_hook, nat_callforwarding);
-	RCU_INIT_POINTER(nat_q931_hook, nat_q931);
+	RCU_INIT_POINTER(nfct_h323_nat_hook, &nathooks);
 	nf_ct_helper_expectfn_register(&q931_nat);
 	nf_ct_helper_expectfn_register(&callforwarding_nat);
 	return 0;
@@ -609,15 +603,7 @@ static int __init nf_nat_h323_init(void)
 /****************************************************************************/
 static void __exit nf_nat_h323_fini(void)
 {
-	RCU_INIT_POINTER(set_h245_addr_hook, NULL);
-	RCU_INIT_POINTER(set_h225_addr_hook, NULL);
-	RCU_INIT_POINTER(set_sig_addr_hook, NULL);
-	RCU_INIT_POINTER(set_ras_addr_hook, NULL);
-	RCU_INIT_POINTER(nat_rtp_rtcp_hook, NULL);
-	RCU_INIT_POINTER(nat_t120_hook, NULL);
-	RCU_INIT_POINTER(nat_h245_hook, NULL);
-	RCU_INIT_POINTER(nat_callforwarding_hook, NULL);
-	RCU_INIT_POINTER(nat_q931_hook, NULL);
+	RCU_INIT_POINTER(nfct_h323_nat_hook, NULL);
 	nf_ct_helper_expectfn_unregister(&q931_nat);
 	nf_ct_helper_expectfn_unregister(&callforwarding_nat);
 	synchronize_rcu();
diff --git a/net/netfilter/nf_conntrack_h323_main.c b/net/netfilter/nf_conntrack_h323_main.c
index 2eb31ffb3d14..8986d1a3c890 100644
--- a/net/netfilter/nf_conntrack_h323_main.c
+++ b/net/netfilter/nf_conntrack_h323_main.c
@@ -49,64 +49,8 @@ MODULE_PARM_DESC(callforward_filter, "only create call forwarding expectations "
 				     "if both endpoints are on different sides "
 				     "(determined by routing information)");
 
-/* Hooks for NAT */
-int (*set_h245_addr_hook) (struct sk_buff *skb, unsigned int protoff,
-			   unsigned char **data, int dataoff,
-			   H245_TransportAddress *taddr,
-			   union nf_inet_addr *addr, __be16 port)
-			   __read_mostly;
-int (*set_h225_addr_hook) (struct sk_buff *skb, unsigned int protoff,
-			   unsigned char **data, int dataoff,
-			   TransportAddress *taddr,
-			   union nf_inet_addr *addr, __be16 port)
-			   __read_mostly;
-int (*set_sig_addr_hook) (struct sk_buff *skb,
-			  struct nf_conn *ct,
-			  enum ip_conntrack_info ctinfo,
-			  unsigned int protoff, unsigned char **data,
-			  TransportAddress *taddr, int count) __read_mostly;
-int (*set_ras_addr_hook) (struct sk_buff *skb,
-			  struct nf_conn *ct,
-			  enum ip_conntrack_info ctinfo,
-			  unsigned int protoff, unsigned char **data,
-			  TransportAddress *taddr, int count) __read_mostly;
-int (*nat_rtp_rtcp_hook) (struct sk_buff *skb,
-			  struct nf_conn *ct,
-			  enum ip_conntrack_info ctinfo,
-			  unsigned int protoff,
-			  unsigned char **data, int dataoff,
-			  H245_TransportAddress *taddr,
-			  __be16 port, __be16 rtp_port,
-			  struct nf_conntrack_expect *rtp_exp,
-			  struct nf_conntrack_expect *rtcp_exp) __read_mostly;
-int (*nat_t120_hook) (struct sk_buff *skb,
-		      struct nf_conn *ct,
-		      enum ip_conntrack_info ctinfo,
-		      unsigned int protoff,
-		      unsigned char **data, int dataoff,
-		      H245_TransportAddress *taddr, __be16 port,
-		      struct nf_conntrack_expect *exp) __read_mostly;
-int (*nat_h245_hook) (struct sk_buff *skb,
-		      struct nf_conn *ct,
-		      enum ip_conntrack_info ctinfo,
-		      unsigned int protoff,
-		      unsigned char **data, int dataoff,
-		      TransportAddress *taddr, __be16 port,
-		      struct nf_conntrack_expect *exp) __read_mostly;
-int (*nat_callforwarding_hook) (struct sk_buff *skb,
-				struct nf_conn *ct,
-				enum ip_conntrack_info ctinfo,
-				unsigned int protoff,
-				unsigned char **data, int dataoff,
-				TransportAddress *taddr, __be16 port,
-				struct nf_conntrack_expect *exp) __read_mostly;
-int (*nat_q931_hook) (struct sk_buff *skb,
-		      struct nf_conn *ct,
-		      enum ip_conntrack_info ctinfo,
-		      unsigned int protoff,
-		      unsigned char **data, TransportAddress *taddr, int idx,
-		      __be16 port, struct nf_conntrack_expect *exp)
-		      __read_mostly;
+const struct nfct_h323_nat_hooks __rcu *nfct_h323_nat_hook __read_mostly;
+EXPORT_SYMBOL_GPL(nfct_h323_nat_hook);
 
 static DEFINE_SPINLOCK(nf_h323_lock);
 static char *h323_buffer;
@@ -259,6 +203,7 @@ static int expect_rtp_rtcp(struct sk_buff *skb, struct nf_conn *ct,
 			   unsigned char **data, int dataoff,
 			   H245_TransportAddress *taddr)
 {
+	const struct nfct_h323_nat_hooks *nathook;
 	int dir = CTINFO2DIR(ctinfo);
 	int ret = 0;
 	__be16 port;
@@ -266,7 +211,6 @@ static int expect_rtp_rtcp(struct sk_buff *skb, struct nf_conn *ct,
 	union nf_inet_addr addr;
 	struct nf_conntrack_expect *rtp_exp;
 	struct nf_conntrack_expect *rtcp_exp;
-	typeof(nat_rtp_rtcp_hook) nat_rtp_rtcp;
 
 	/* Read RTP or RTCP address */
 	if (!get_h245_addr(ct, *data, taddr, &addr, &port) ||
@@ -296,15 +240,16 @@ static int expect_rtp_rtcp(struct sk_buff *skb, struct nf_conn *ct,
 			  &ct->tuplehash[!dir].tuple.dst.u3,
 			  IPPROTO_UDP, NULL, &rtcp_port);
 
+	nathook = rcu_dereference(nfct_h323_nat_hook);
 	if (memcmp(&ct->tuplehash[dir].tuple.src.u3,
 		   &ct->tuplehash[!dir].tuple.dst.u3,
 		   sizeof(ct->tuplehash[dir].tuple.src.u3)) &&
-		   (nat_rtp_rtcp = rcu_dereference(nat_rtp_rtcp_hook)) &&
+		   nathook &&
 		   nf_ct_l3num(ct) == NFPROTO_IPV4 &&
 		   ct->status & IPS_NAT_MASK) {
 		/* NAT needed */
-		ret = nat_rtp_rtcp(skb, ct, ctinfo, protoff, data, dataoff,
-				   taddr, port, rtp_port, rtp_exp, rtcp_exp);
+		ret = nathook->nat_rtp_rtcp(skb, ct, ctinfo, protoff, data, dataoff,
+					    taddr, port, rtp_port, rtp_exp, rtcp_exp);
 	} else {		/* Conntrack only */
 		if (nf_ct_expect_related(rtp_exp, 0) == 0) {
 			if (nf_ct_expect_related(rtcp_exp, 0) == 0) {
@@ -333,12 +278,12 @@ static int expect_t120(struct sk_buff *skb,
 		       unsigned char **data, int dataoff,
 		       H245_TransportAddress *taddr)
 {
+	const struct nfct_h323_nat_hooks *nathook;
 	int dir = CTINFO2DIR(ctinfo);
 	int ret = 0;
 	__be16 port;
 	union nf_inet_addr addr;
 	struct nf_conntrack_expect *exp;
-	typeof(nat_t120_hook) nat_t120;
 
 	/* Read T.120 address */
 	if (!get_h245_addr(ct, *data, taddr, &addr, &port) ||
@@ -355,15 +300,16 @@ static int expect_t120(struct sk_buff *skb,
 			  IPPROTO_TCP, NULL, &port);
 	exp->flags = NF_CT_EXPECT_PERMANENT;	/* Accept multiple channels */
 
+	nathook = rcu_dereference(nfct_h323_nat_hook);
 	if (memcmp(&ct->tuplehash[dir].tuple.src.u3,
 		   &ct->tuplehash[!dir].tuple.dst.u3,
 		   sizeof(ct->tuplehash[dir].tuple.src.u3)) &&
-	    (nat_t120 = rcu_dereference(nat_t120_hook)) &&
+	    nathook &&
 	    nf_ct_l3num(ct) == NFPROTO_IPV4 &&
 	    ct->status & IPS_NAT_MASK) {
 		/* NAT needed */
-		ret = nat_t120(skb, ct, ctinfo, protoff, data, dataoff, taddr,
-			       port, exp);
+		ret = nathook->nat_t120(skb, ct, ctinfo, protoff, data,
+					dataoff, taddr, port, exp);
 	} else {		/* Conntrack only */
 		if (nf_ct_expect_related(exp, 0) == 0) {
 			pr_debug("nf_ct_h323: expect T.120 ");
@@ -670,12 +616,12 @@ static int expect_h245(struct sk_buff *skb, struct nf_conn *ct,
 		       unsigned int protoff, unsigned char **data, int dataoff,
 		       TransportAddress *taddr)
 {
+	const struct nfct_h323_nat_hooks *nathook;
 	int dir = CTINFO2DIR(ctinfo);
 	int ret = 0;
 	__be16 port;
 	union nf_inet_addr addr;
 	struct nf_conntrack_expect *exp;
-	typeof(nat_h245_hook) nat_h245;
 
 	/* Read h245Address */
 	if (!get_h225_addr(ct, *data, taddr, &addr, &port) ||
@@ -692,15 +638,16 @@ static int expect_h245(struct sk_buff *skb, struct nf_conn *ct,
 			  IPPROTO_TCP, NULL, &port);
 	exp->helper = &nf_conntrack_helper_h245;
 
+	nathook = rcu_dereference(nfct_h323_nat_hook);
 	if (memcmp(&ct->tuplehash[dir].tuple.src.u3,
 		   &ct->tuplehash[!dir].tuple.dst.u3,
 		   sizeof(ct->tuplehash[dir].tuple.src.u3)) &&
-	    (nat_h245 = rcu_dereference(nat_h245_hook)) &&
+	    nathook &&
 	    nf_ct_l3num(ct) == NFPROTO_IPV4 &&
 	    ct->status & IPS_NAT_MASK) {
 		/* NAT needed */
-		ret = nat_h245(skb, ct, ctinfo, protoff, data, dataoff, taddr,
-			       port, exp);
+		ret = nathook->nat_h245(skb, ct, ctinfo, protoff, data,
+					dataoff, taddr, port, exp);
 	} else {		/* Conntrack only */
 		if (nf_ct_expect_related(exp, 0) == 0) {
 			pr_debug("nf_ct_q931: expect H.245 ");
@@ -785,13 +732,13 @@ static int expect_callforwarding(struct sk_buff *skb,
 				 unsigned char **data, int dataoff,
 				 TransportAddress *taddr)
 {
+	const struct nfct_h323_nat_hooks *nathook;
 	int dir = CTINFO2DIR(ctinfo);
 	int ret = 0;
 	__be16 port;
 	union nf_inet_addr addr;
 	struct nf_conntrack_expect *exp;
 	struct net *net = nf_ct_net(ct);
-	typeof(nat_callforwarding_hook) nat_callforwarding;
 
 	/* Read alternativeAddress */
 	if (!get_h225_addr(ct, *data, taddr, &addr, &port) || port == 0)
@@ -815,16 +762,17 @@ static int expect_callforwarding(struct sk_buff *skb,
 			  IPPROTO_TCP, NULL, &port);
 	exp->helper = nf_conntrack_helper_q931;
 
+	nathook = rcu_dereference(nfct_h323_nat_hook);
 	if (memcmp(&ct->tuplehash[dir].tuple.src.u3,
 		   &ct->tuplehash[!dir].tuple.dst.u3,
 		   sizeof(ct->tuplehash[dir].tuple.src.u3)) &&
-	    (nat_callforwarding = rcu_dereference(nat_callforwarding_hook)) &&
+	    nathook &&
 	    nf_ct_l3num(ct) == NFPROTO_IPV4 &&
 	    ct->status & IPS_NAT_MASK) {
 		/* Need NAT */
-		ret = nat_callforwarding(skb, ct, ctinfo,
-					 protoff, data, dataoff,
-					 taddr, port, exp);
+		ret = nathook->nat_callforwarding(skb, ct, ctinfo,
+						  protoff, data, dataoff,
+						  taddr, port, exp);
 	} else {		/* Conntrack only */
 		if (nf_ct_expect_related(exp, 0) == 0) {
 			pr_debug("nf_ct_q931: expect Call Forwarding ");
@@ -844,12 +792,12 @@ static int process_setup(struct sk_buff *skb, struct nf_conn *ct,
 			 unsigned char **data, int dataoff,
 			 Setup_UUIE *setup)
 {
+	const struct nfct_h323_nat_hooks *nathook;
 	int dir = CTINFO2DIR(ctinfo);
 	int ret;
 	int i;
 	__be16 port;
 	union nf_inet_addr addr;
-	typeof(set_h225_addr_hook) set_h225_addr;
 
 	pr_debug("nf_ct_q931: Setup\n");
 
@@ -860,9 +808,9 @@ static int process_setup(struct sk_buff *skb, struct nf_conn *ct,
 			return -1;
 	}
 
-	set_h225_addr = rcu_dereference(set_h225_addr_hook);
+	nathook = rcu_dereference(nfct_h323_nat_hook);
 	if ((setup->options & eSetup_UUIE_destCallSignalAddress) &&
-	    (set_h225_addr) && nf_ct_l3num(ct) == NFPROTO_IPV4 &&
+	    nathook && nf_ct_l3num(ct) == NFPROTO_IPV4 &&
 	    ct->status & IPS_NAT_MASK &&
 	    get_h225_addr(ct, *data, &setup->destCallSignalAddress,
 			  &addr, &port) &&
@@ -870,16 +818,16 @@ static int process_setup(struct sk_buff *skb, struct nf_conn *ct,
 		pr_debug("nf_ct_q931: set destCallSignalAddress %pI6:%hu->%pI6:%hu\n",
 			 &addr, ntohs(port), &ct->tuplehash[!dir].tuple.src.u3,
 			 ntohs(ct->tuplehash[!dir].tuple.src.u.tcp.port));
-		ret = set_h225_addr(skb, protoff, data, dataoff,
-				    &setup->destCallSignalAddress,
-				    &ct->tuplehash[!dir].tuple.src.u3,
-				    ct->tuplehash[!dir].tuple.src.u.tcp.port);
+		ret = nathook->set_h225_addr(skb, protoff, data, dataoff,
+					     &setup->destCallSignalAddress,
+					     &ct->tuplehash[!dir].tuple.src.u3,
+					     ct->tuplehash[!dir].tuple.src.u.tcp.port);
 		if (ret < 0)
 			return -1;
 	}
 
 	if ((setup->options & eSetup_UUIE_sourceCallSignalAddress) &&
-	    (set_h225_addr) && nf_ct_l3num(ct) == NFPROTO_IPV4 &&
+	    nathook && nf_ct_l3num(ct) == NFPROTO_IPV4 &&
 	    ct->status & IPS_NAT_MASK &&
 	    get_h225_addr(ct, *data, &setup->sourceCallSignalAddress,
 			  &addr, &port) &&
@@ -887,10 +835,10 @@ static int process_setup(struct sk_buff *skb, struct nf_conn *ct,
 		pr_debug("nf_ct_q931: set sourceCallSignalAddress %pI6:%hu->%pI6:%hu\n",
 			 &addr, ntohs(port), &ct->tuplehash[!dir].tuple.dst.u3,
 			 ntohs(ct->tuplehash[!dir].tuple.dst.u.tcp.port));
-		ret = set_h225_addr(skb, protoff, data, dataoff,
-				    &setup->sourceCallSignalAddress,
-				    &ct->tuplehash[!dir].tuple.dst.u3,
-				    ct->tuplehash[!dir].tuple.dst.u.tcp.port);
+		ret = nathook->set_h225_addr(skb, protoff, data, dataoff,
+					     &setup->sourceCallSignalAddress,
+					     &ct->tuplehash[!dir].tuple.dst.u3,
+					     ct->tuplehash[!dir].tuple.dst.u.tcp.port);
 		if (ret < 0)
 			return -1;
 	}
@@ -1249,13 +1197,13 @@ static int expect_q931(struct sk_buff *skb, struct nf_conn *ct,
 		       TransportAddress *taddr, int count)
 {
 	struct nf_ct_h323_master *info = nfct_help_data(ct);
+	const struct nfct_h323_nat_hooks *nathook;
 	int dir = CTINFO2DIR(ctinfo);
 	int ret = 0;
 	int i;
 	__be16 port;
 	union nf_inet_addr addr;
 	struct nf_conntrack_expect *exp;
-	typeof(nat_q931_hook) nat_q931;
 
 	/* Look for the first related address */
 	for (i = 0; i < count; i++) {
@@ -1279,11 +1227,11 @@ static int expect_q931(struct sk_buff *skb, struct nf_conn *ct,
 	exp->helper = nf_conntrack_helper_q931;
 	exp->flags = NF_CT_EXPECT_PERMANENT;	/* Accept multiple calls */
 
-	nat_q931 = rcu_dereference(nat_q931_hook);
-	if (nat_q931 && nf_ct_l3num(ct) == NFPROTO_IPV4 &&
+	nathook = rcu_dereference(nfct_h323_nat_hook);
+	if (nathook && nf_ct_l3num(ct) == NFPROTO_IPV4 &&
 	    ct->status & IPS_NAT_MASK) {	/* Need NAT */
-		ret = nat_q931(skb, ct, ctinfo, protoff, data,
-			       taddr, i, port, exp);
+		ret = nathook->nat_q931(skb, ct, ctinfo, protoff, data,
+					taddr, i, port, exp);
 	} else {		/* Conntrack only */
 		if (nf_ct_expect_related(exp, 0) == 0) {
 			pr_debug("nf_ct_ras: expect Q.931 ");
@@ -1305,15 +1253,15 @@ static int process_grq(struct sk_buff *skb, struct nf_conn *ct,
 		       unsigned int protoff,
 		       unsigned char **data, GatekeeperRequest *grq)
 {
-	typeof(set_ras_addr_hook) set_ras_addr;
+	const struct nfct_h323_nat_hooks *nathook;
 
 	pr_debug("nf_ct_ras: GRQ\n");
 
-	set_ras_addr = rcu_dereference(set_ras_addr_hook);
-	if (set_ras_addr && nf_ct_l3num(ct) == NFPROTO_IPV4 &&
+	nathook = rcu_dereference(nfct_h323_nat_hook);
+	if (nathook && nf_ct_l3num(ct) == NFPROTO_IPV4 &&
 	    ct->status & IPS_NAT_MASK)	/* NATed */
-		return set_ras_addr(skb, ct, ctinfo, protoff, data,
-				    &grq->rasAddress, 1);
+		return nathook->set_ras_addr(skb, ct, ctinfo, protoff, data,
+					     &grq->rasAddress, 1);
 	return 0;
 }
 
@@ -1367,8 +1315,8 @@ static int process_rrq(struct sk_buff *skb, struct nf_conn *ct,
 		       unsigned char **data, RegistrationRequest *rrq)
 {
 	struct nf_ct_h323_master *info = nfct_help_data(ct);
+	const struct nfct_h323_nat_hooks *nathook;
 	int ret;
-	typeof(set_ras_addr_hook) set_ras_addr;
 
 	pr_debug("nf_ct_ras: RRQ\n");
 
@@ -1378,12 +1326,12 @@ static int process_rrq(struct sk_buff *skb, struct nf_conn *ct,
 	if (ret < 0)
 		return -1;
 
-	set_ras_addr = rcu_dereference(set_ras_addr_hook);
-	if (set_ras_addr && nf_ct_l3num(ct) == NFPROTO_IPV4 &&
+	nathook = rcu_dereference(nfct_h323_nat_hook);
+	if (nathook && nf_ct_l3num(ct) == NFPROTO_IPV4 &&
 	    ct->status & IPS_NAT_MASK) {
-		ret = set_ras_addr(skb, ct, ctinfo, protoff, data,
-				   rrq->rasAddress.item,
-				   rrq->rasAddress.count);
+		ret = nathook->set_ras_addr(skb, ct, ctinfo, protoff, data,
+					    rrq->rasAddress.item,
+					    rrq->rasAddress.count);
 		if (ret < 0)
 			return -1;
 	}
@@ -1403,19 +1351,19 @@ static int process_rcf(struct sk_buff *skb, struct nf_conn *ct,
 		       unsigned char **data, RegistrationConfirm *rcf)
 {
 	struct nf_ct_h323_master *info = nfct_help_data(ct);
+	const struct nfct_h323_nat_hooks *nathook;
 	int dir = CTINFO2DIR(ctinfo);
 	int ret;
 	struct nf_conntrack_expect *exp;
-	typeof(set_sig_addr_hook) set_sig_addr;
 
 	pr_debug("nf_ct_ras: RCF\n");
 
-	set_sig_addr = rcu_dereference(set_sig_addr_hook);
-	if (set_sig_addr && nf_ct_l3num(ct) == NFPROTO_IPV4 &&
+	nathook = rcu_dereference(nfct_h323_nat_hook);
+	if (nathook && nf_ct_l3num(ct) == NFPROTO_IPV4 &&
 	    ct->status & IPS_NAT_MASK) {
-		ret = set_sig_addr(skb, ct, ctinfo, protoff, data,
-					rcf->callSignalAddress.item,
-					rcf->callSignalAddress.count);
+		ret = nathook->set_sig_addr(skb, ct, ctinfo, protoff, data,
+					    rcf->callSignalAddress.item,
+					    rcf->callSignalAddress.count);
 		if (ret < 0)
 			return -1;
 	}
@@ -1454,18 +1402,18 @@ static int process_urq(struct sk_buff *skb, struct nf_conn *ct,
 		       unsigned char **data, UnregistrationRequest *urq)
 {
 	struct nf_ct_h323_master *info = nfct_help_data(ct);
+	const struct nfct_h323_nat_hooks *nathook;
 	int dir = CTINFO2DIR(ctinfo);
 	int ret;
-	typeof(set_sig_addr_hook) set_sig_addr;
 
 	pr_debug("nf_ct_ras: URQ\n");
 
-	set_sig_addr = rcu_dereference(set_sig_addr_hook);
-	if (set_sig_addr && nf_ct_l3num(ct) == NFPROTO_IPV4 &&
+	nathook = rcu_dereference(nfct_h323_nat_hook);
+	if (nathook && nf_ct_l3num(ct) == NFPROTO_IPV4 &&
 	    ct->status & IPS_NAT_MASK) {
-		ret = set_sig_addr(skb, ct, ctinfo, protoff, data,
-				   urq->callSignalAddress.item,
-				   urq->callSignalAddress.count);
+		ret = nathook->set_sig_addr(skb, ct, ctinfo, protoff, data,
+					    urq->callSignalAddress.item,
+					    urq->callSignalAddress.count);
 		if (ret < 0)
 			return -1;
 	}
@@ -1487,39 +1435,42 @@ static int process_arq(struct sk_buff *skb, struct nf_conn *ct,
 		       unsigned char **data, AdmissionRequest *arq)
 {
 	const struct nf_ct_h323_master *info = nfct_help_data(ct);
+	const struct nfct_h323_nat_hooks *nathook;
 	int dir = CTINFO2DIR(ctinfo);
 	__be16 port;
 	union nf_inet_addr addr;
-	typeof(set_h225_addr_hook) set_h225_addr;
 
 	pr_debug("nf_ct_ras: ARQ\n");
 
-	set_h225_addr = rcu_dereference(set_h225_addr_hook);
+	nathook = rcu_dereference(nfct_h323_nat_hook);
+	if (!nathook)
+		return 0;
+
 	if ((arq->options & eAdmissionRequest_destCallSignalAddress) &&
 	    get_h225_addr(ct, *data, &arq->destCallSignalAddress,
 			  &addr, &port) &&
 	    !memcmp(&addr, &ct->tuplehash[dir].tuple.src.u3, sizeof(addr)) &&
 	    port == info->sig_port[dir] &&
 	    nf_ct_l3num(ct) == NFPROTO_IPV4 &&
-	    set_h225_addr && ct->status & IPS_NAT_MASK) {
+	    ct->status & IPS_NAT_MASK) {
 		/* Answering ARQ */
-		return set_h225_addr(skb, protoff, data, 0,
-				     &arq->destCallSignalAddress,
-				     &ct->tuplehash[!dir].tuple.dst.u3,
-				     info->sig_port[!dir]);
+		return nathook->set_h225_addr(skb, protoff, data, 0,
+					      &arq->destCallSignalAddress,
+					      &ct->tuplehash[!dir].tuple.dst.u3,
+					      info->sig_port[!dir]);
 	}
 
 	if ((arq->options & eAdmissionRequest_srcCallSignalAddress) &&
 	    get_h225_addr(ct, *data, &arq->srcCallSignalAddress,
 			  &addr, &port) &&
 	    !memcmp(&addr, &ct->tuplehash[dir].tuple.src.u3, sizeof(addr)) &&
-	    set_h225_addr && nf_ct_l3num(ct) == NFPROTO_IPV4 &&
+	    nf_ct_l3num(ct) == NFPROTO_IPV4 &&
 	    ct->status & IPS_NAT_MASK) {
 		/* Calling ARQ */
-		return set_h225_addr(skb, protoff, data, 0,
-				     &arq->srcCallSignalAddress,
-				     &ct->tuplehash[!dir].tuple.dst.u3,
-				     port);
+		return nathook->set_h225_addr(skb, protoff, data, 0,
+					      &arq->srcCallSignalAddress,
+					      &ct->tuplehash[!dir].tuple.dst.u3,
+					      port);
 	}
 
 	return 0;
@@ -1535,7 +1486,6 @@ static int process_acf(struct sk_buff *skb, struct nf_conn *ct,
 	__be16 port;
 	union nf_inet_addr addr;
 	struct nf_conntrack_expect *exp;
-	typeof(set_sig_addr_hook) set_sig_addr;
 
 	pr_debug("nf_ct_ras: ACF\n");
 
@@ -1544,12 +1494,15 @@ static int process_acf(struct sk_buff *skb, struct nf_conn *ct,
 		return 0;
 
 	if (!memcmp(&addr, &ct->tuplehash[dir].tuple.dst.u3, sizeof(addr))) {
+		const struct nfct_h323_nat_hooks *nathook;
+
 		/* Answering ACF */
-		set_sig_addr = rcu_dereference(set_sig_addr_hook);
-		if (set_sig_addr && nf_ct_l3num(ct) == NFPROTO_IPV4 &&
+		nathook = rcu_dereference(nfct_h323_nat_hook);
+		if (nathook && nf_ct_l3num(ct) == NFPROTO_IPV4 &&
 		    ct->status & IPS_NAT_MASK)
-			return set_sig_addr(skb, ct, ctinfo, protoff, data,
-					    &acf->destCallSignalAddress, 1);
+			return nathook->set_sig_addr(skb, ct, ctinfo, protoff,
+						     data,
+						     &acf->destCallSignalAddress, 1);
 		return 0;
 	}
 
@@ -1578,15 +1531,15 @@ static int process_lrq(struct sk_buff *skb, struct nf_conn *ct,
 		       unsigned int protoff,
 		       unsigned char **data, LocationRequest *lrq)
 {
-	typeof(set_ras_addr_hook) set_ras_addr;
+	const struct nfct_h323_nat_hooks *nathook;
 
 	pr_debug("nf_ct_ras: LRQ\n");
 
-	set_ras_addr = rcu_dereference(set_ras_addr_hook);
-	if (set_ras_addr && nf_ct_l3num(ct) == NFPROTO_IPV4 &&
+	nathook = rcu_dereference(nfct_h323_nat_hook);
+	if (nathook && nf_ct_l3num(ct) == NFPROTO_IPV4 &&
 	    ct->status & IPS_NAT_MASK)
-		return set_ras_addr(skb, ct, ctinfo, protoff, data,
-				    &lrq->replyAddress, 1);
+		return nathook->set_ras_addr(skb, ct, ctinfo, protoff, data,
+					     &lrq->replyAddress, 1);
 	return 0;
 }
 
@@ -1634,27 +1587,22 @@ static int process_irr(struct sk_buff *skb, struct nf_conn *ct,
 		       unsigned int protoff,
 		       unsigned char **data, InfoRequestResponse *irr)
 {
+	const struct nfct_h323_nat_hooks *nathook;
 	int ret;
-	typeof(set_ras_addr_hook) set_ras_addr;
-	typeof(set_sig_addr_hook) set_sig_addr;
 
 	pr_debug("nf_ct_ras: IRR\n");
 
-	set_ras_addr = rcu_dereference(set_ras_addr_hook);
-	if (set_ras_addr && nf_ct_l3num(ct) == NFPROTO_IPV4 &&
+	nathook = rcu_dereference(nfct_h323_nat_hook);
+	if (nathook && nf_ct_l3num(ct) == NFPROTO_IPV4 &&
 	    ct->status & IPS_NAT_MASK) {
-		ret = set_ras_addr(skb, ct, ctinfo, protoff, data,
-				   &irr->rasAddress, 1);
+		ret = nathook->set_ras_addr(skb, ct, ctinfo, protoff, data,
+					    &irr->rasAddress, 1);
 		if (ret < 0)
 			return -1;
-	}
 
-	set_sig_addr = rcu_dereference(set_sig_addr_hook);
-	if (set_sig_addr && nf_ct_l3num(ct) == NFPROTO_IPV4 &&
-	    ct->status & IPS_NAT_MASK) {
-		ret = set_sig_addr(skb, ct, ctinfo, protoff, data,
-					irr->callSignalAddress.item,
-					irr->callSignalAddress.count);
+		ret = nathook->set_sig_addr(skb, ct, ctinfo, protoff, data,
+					    irr->callSignalAddress.item,
+					    irr->callSignalAddress.count);
 		if (ret < 0)
 			return -1;
 	}
@@ -1837,17 +1785,6 @@ static int __init nf_conntrack_h323_init(void)
 module_init(nf_conntrack_h323_init);
 module_exit(nf_conntrack_h323_fini);
 
-EXPORT_SYMBOL_GPL(get_h225_addr);
-EXPORT_SYMBOL_GPL(set_h245_addr_hook);
-EXPORT_SYMBOL_GPL(set_h225_addr_hook);
-EXPORT_SYMBOL_GPL(set_sig_addr_hook);
-EXPORT_SYMBOL_GPL(set_ras_addr_hook);
-EXPORT_SYMBOL_GPL(nat_rtp_rtcp_hook);
-EXPORT_SYMBOL_GPL(nat_t120_hook);
-EXPORT_SYMBOL_GPL(nat_h245_hook);
-EXPORT_SYMBOL_GPL(nat_callforwarding_hook);
-EXPORT_SYMBOL_GPL(nat_q931_hook);
-
 MODULE_AUTHOR("Jing Min Zhao <zhaojingmin@users.sourceforge.net>");
 MODULE_DESCRIPTION("H.323 connection tracking helper");
 MODULE_LICENSE("GPL");
-- 
2.35.1

