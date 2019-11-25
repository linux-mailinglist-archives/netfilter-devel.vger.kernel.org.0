Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21115108DBB
	for <lists+netfilter-devel@lfdr.de>; Mon, 25 Nov 2019 13:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfKYMU6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 25 Nov 2019 07:20:58 -0500
Received: from correo.us.es ([193.147.175.20]:41538 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbfKYMU5 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 25 Nov 2019 07:20:57 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id F2CBCE043F
        for <netfilter-devel@vger.kernel.org>; Mon, 25 Nov 2019 13:20:53 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 2D073D190C
        for <netfilter-devel@vger.kernel.org>; Mon, 25 Nov 2019 13:20:53 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 22BDE8E631; Mon, 25 Nov 2019 13:20:53 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id DD82EA8271;
        Mon, 25 Nov 2019 13:20:50 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 25 Nov 2019 13:20:50 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id AB39C42EF42C;
        Mon, 25 Nov 2019 13:20:50 +0100 (CET)
Date:   Mon, 25 Nov 2019 13:20:52 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nftables v2 1/2] src: add ability to set/get secmarks
 to/from connection
Message-ID: <20191125122052.f6qtdu7i43skylcp@salvia>
References: <20191123162240.14571-1-cgzones@googlemail.com>
 <20191125121012.semtalw5sgwm5uev@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191125121012.semtalw5sgwm5uev@salvia>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Nov 25, 2019 at 01:10:12PM +0100, Pablo Neira Ayuso wrote:
> Hi Christian,
> 
> On Sat, Nov 23, 2019 at 05:22:39PM +0100, Christian G�ttsche wrote:
> [...]
> > v2: - incorporate changes suggested by Pablo Neira Ayuso
> >     - invalidate setting ct secmark to a constant value, like:
> >         ct secmark set 12
> >       Note:
> >       statements setting the meta secmark, like
> >         meta secmark set 12
> >       must accept constant values, cause the secmark object identifier
> >       is a string
> >         meta secmark set "icmp_client"
> 
> This is represented as a object reference statement from the parser.
> 
> It should be safe to do the same check from stmt_evaluate_meta() that
> this patch does for stmt_evaluate_ct().

Oh, now I understand what you describe, your patch looks good indeed.

> >       12 is probably not a used secmark object identifier, so it will
> >       fail:
> >         nft add rule inet filter input meta secmark set 12
> >         Error: Could not process rule: No such file or directory
> >         add rule inet filter input meta secmark set 12
> >         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >  src/ct.c           |  2 ++
> >  src/evaluate.c     | 24 ++++++++++++++++++++++--
> >  src/meta.c         |  2 ++
> >  src/parser_bison.y | 14 +++++++++++---
> >  4 files changed, 37 insertions(+), 5 deletions(-)
> > 
> > diff --git a/src/ct.c b/src/ct.c
> > index ed458e6b..9e6a8351 100644
> > --- a/src/ct.c
> > +++ b/src/ct.c
> > @@ -299,6 +299,8 @@ const struct ct_template ct_templates[__NFT_CT_MAX] = {
> >  					      BYTEORDER_BIG_ENDIAN, 128),
> >  	[NFT_CT_DST_IP6]	= CT_TEMPLATE("ip6 daddr", &ip6addr_type,
> >  					      BYTEORDER_BIG_ENDIAN, 128),
> > +	[NFT_CT_SECMARK]	= CT_TEMPLATE("secmark", &integer_type,
> > +					      BYTEORDER_HOST_ENDIAN, 32),
> >  };
> >  
> >  static void ct_print(enum nft_ct_keys key, int8_t dir, uint8_t nfproto,
> > diff --git a/src/evaluate.c b/src/evaluate.c
> > index e54eaf1a..a865902c 100644
> > --- a/src/evaluate.c
> > +++ b/src/evaluate.c
> > @@ -1784,6 +1784,18 @@ static int expr_evaluate_relational(struct eval_ctx *ctx, struct expr **expr)
> >  					 left->dtype->desc,
> >  					 right->dtype->desc);
> >  
> > +	/*
> > +	 * Statements like 'ct secmark 12' are parsed as relational,
> > +	 * disallow constant value on the right hand side.
> > +	 */
> > +	if (((left->etype == EXPR_META &&
> > +	      left->meta.key == NFT_META_SECMARK) ||
> > +	     (left->etype == EXPR_CT &&
> > +	      left->ct.key == NFT_CT_SECMARK)) &&
> > +	    right->flags & EXPR_F_CONSTANT)
> > +		return expr_binary_error(ctx->msgs, right, left,
> > +					 "Cannot be used with right hand side constant value");
> > +
> >  	switch (rel->op) {
> >  	case OP_EQ:
> >  	case OP_IMPLICIT:
> > @@ -2319,11 +2331,19 @@ static int stmt_evaluate_meta(struct eval_ctx *ctx, struct stmt *stmt)
> >  
> >  static int stmt_evaluate_ct(struct eval_ctx *ctx, struct stmt *stmt)
> >  {
> > -	return stmt_evaluate_arg(ctx, stmt,
> > +	if (stmt_evaluate_arg(ctx, stmt,
> >  				 stmt->ct.tmpl->dtype,
> >  				 stmt->ct.tmpl->len,
> >  				 stmt->ct.tmpl->byteorder,
> > -				 &stmt->ct.expr);
> > +				 &stmt->ct.expr) < 0)
> > +		return -1;
> > +
> > +	if (stmt->ct.key == NFT_CT_SECMARK &&
> > +	    expr_is_constant(stmt->ct.expr))
> > +		return stmt_error(ctx, stmt,
> > +				  "ct secmark must not be set to constant value");
> > +
> > +	return 0;
> >  }
> >  
> >  static int reject_payload_gen_dependency_tcp(struct eval_ctx *ctx,
> > diff --git a/src/meta.c b/src/meta.c
> > index 69a897a9..796d8e94 100644
> > --- a/src/meta.c
> > +++ b/src/meta.c
> > @@ -698,6 +698,8 @@ const struct meta_template meta_templates[] = {
> >  	[NFT_META_TIME_HOUR]	= META_TEMPLATE("hour", &hour_type,
> >  						4 * BITS_PER_BYTE,
> >  						BYTEORDER_HOST_ENDIAN),
> > +	[NFT_META_SECMARK]	= META_TEMPLATE("secmark", &integer_type,
> > +						32, BYTEORDER_HOST_ENDIAN),
> >  };
> >  
> >  static bool meta_key_is_unqualified(enum nft_meta_keys key)
> > diff --git a/src/parser_bison.y b/src/parser_bison.y
> > index 631b7d68..707f4671 100644
> > --- a/src/parser_bison.y
> > +++ b/src/parser_bison.y
> > @@ -4190,9 +4190,16 @@ meta_stmt		:	META	meta_key	SET	stmt_expr
> >  			{
> >  				switch ($2) {
> >  				case NFT_META_SECMARK:
> > -					$$ = objref_stmt_alloc(&@$);
> > -					$$->objref.type = NFT_OBJECT_SECMARK;
> > -					$$->objref.expr = $4;
> > +					switch ($4->etype) {
> > +					case EXPR_CT:
> > +						$$ = meta_stmt_alloc(&@$, $2, $4);
> > +						break;
> > +					default:
> > +						$$ = objref_stmt_alloc(&@$);
> > +						$$->objref.type = NFT_OBJECT_SECMARK;
> > +						$$->objref.expr = $4;
> > +						break;
> > +					}
> >  					break;
> >  				default:
> >  					$$ = meta_stmt_alloc(&@$, $2, $4);
> > @@ -4388,6 +4395,7 @@ ct_key			:	L3PROTOCOL	{ $$ = NFT_CT_L3PROTOCOL; }
> >  			|	PROTO_DST	{ $$ = NFT_CT_PROTO_DST; }
> >  			|	LABEL		{ $$ = NFT_CT_LABELS; }
> >  			|	EVENT		{ $$ = NFT_CT_EVENTMASK; }
> > +			|	SECMARK		{ $$ = NFT_CT_SECMARK; }
> >  			|	ct_key_dir_optional
> >  			;
> >  
> > -- 
> > 2.24.0
> > 
