Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659F32A886F
	for <lists+netfilter-devel@lfdr.de>; Thu,  5 Nov 2020 21:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbgKEU5r (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 5 Nov 2020 15:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgKEU5r (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 5 Nov 2020 15:57:47 -0500
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1A9C0613CF
        for <netfilter-devel@vger.kernel.org>; Thu,  5 Nov 2020 12:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=A93e8rTP4Jw0UVD9SRaKh62759yXmCPJzrehhgAPBvU=; b=tSmfay1PHJkCZ61Ubkmp9xL6Co
        DNv2Oz21T2ukYt5+EEPDGxHnmRXNRLbyKAhjKT+k3otDhYaFZS6/AEg15t6XS6umfz1FL6XuFuDyg
        Mp1VAVrsNN9dpRyfrQWuC8LF+a3RBKiMaOEE0Z5HFf+CFVvibDVjRvgBUzYXzA6wTBw/Q6SydePVx
        KNKBSZ3RzpzSuxGLQ4/KMfoH0pSEYrfMGrlBZGu9AMK7Z+JPCFqDGjYZmYI8+E8aB6xjM/dQrOtHp
        98eElfG4WLVvmu9J6h8+XCGgXyIxAlB94erREZRVvMaTdUWVYsl4Z9FB3s2AeJF681mywVgf4l7bM
        uMHxwx9A==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1kamKH-0000al-Gs; Thu, 05 Nov 2020 20:57:45 +0000
Date:   Thu, 5 Nov 2020 20:57:42 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft 5/7] tcpopt: allow to check for presence of any tcp
 option
Message-ID: <20201105205742.GB49955@ulthar.dreamlands>
References: <20201105141144.31430-1-fw@strlen.de>
 <20201105141144.31430-6-fw@strlen.de>
 <20201105191146.GA49955@ulthar.dreamlands>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
Content-Disposition: inline
In-Reply-To: <20201105191146.GA49955@ulthar.dreamlands>
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 2020-11-05, at 19:11:46 +0000, Jeremy Sowden wrote:
> On 2020-11-05, at 15:11:42 +0100, Florian Westphal wrote:
> > nft currently doesn't allow to check for presence of arbitrary tcp options.
> > Only known options where nft provides a template can be tested for.
> >
> > This allows to test for presence of raw protocol values as well.
> >
> > Example:
> >
> > tcp option 42 exists
> >
> > Signed-off-by: Florian Westphal <fw@strlen.de>
> > ---
> >  include/expression.h          |  3 +-
> >  src/exthdr.c                  | 12 ++++++++
> >  src/ipopt.c                   |  1 +
> >  src/netlink_linearize.c       |  2 +-
> >  src/parser_bison.y            |  7 +++++
> >  src/tcpopt.c                  | 42 +++++++++++++++++++++++----
> >  tests/py/any/tcpopt.t         |  2 ++
> >  tests/py/any/tcpopt.t.payload | 53 +++--------------------------------
> >  8 files changed, 65 insertions(+), 57 deletions(-)
> >
> > diff --git a/include/expression.h b/include/expression.h
> > index b039882cf1d1..894a68d2e822 100644
> > --- a/include/expression.h
> > +++ b/include/expression.h
> > @@ -311,7 +311,8 @@ struct expr {
> >  			/* EXPR_EXTHDR */
> >  			const struct exthdr_desc	*desc;
> >  			const struct proto_hdr_template	*tmpl;
> > -			unsigned int			offset;
> > +			uint16_t			offset;
> > +			uint8_t				raw_type;
> >  			enum nft_exthdr_op		op;
> >  			unsigned int			flags;
> >  		} exthdr;
> > diff --git a/src/exthdr.c b/src/exthdr.c
> > index e1b7f14d4194..8995ad1775a0 100644
> > --- a/src/exthdr.c
> > +++ b/src/exthdr.c
> > @@ -52,6 +52,13 @@ static void exthdr_expr_print(const struct expr *expr, struct output_ctx *octx)
> >  		 */
> >  		unsigned int offset = expr->exthdr.offset / 64;
> >
> > +		if (expr->exthdr.desc == NULL &&
> > +		    expr->exthdr.offset == 0 &&
> > +		    expr->exthdr.flags & NFT_EXTHDR_F_PRESENT) {
> > +			nft_print(octx, "tcp option %d", expr->exthdr.raw_type);
> > +			return;
> > +		}
> > +
> >  		nft_print(octx, "tcp option %s", expr->exthdr.desc->name);
> >  		if (expr->exthdr.flags & NFT_EXTHDR_F_PRESENT)
> >  			return;
> > @@ -79,6 +86,7 @@ static bool exthdr_expr_cmp(const struct expr *e1, const struct expr *e2)
> >  	return e1->exthdr.desc == e2->exthdr.desc &&
> >  	       e1->exthdr.tmpl == e2->exthdr.tmpl &&
> >  	       e1->exthdr.op == e2->exthdr.op &&
> > +	       e1->exthdr.raw_type == e2->exthdr.raw_type &&
> >  	       e1->exthdr.flags == e2->exthdr.flags;
> >  }
> >
> > @@ -89,6 +97,7 @@ static void exthdr_expr_clone(struct expr *new, const struct expr *expr)
> >  	new->exthdr.offset = expr->exthdr.offset;
> >  	new->exthdr.op = expr->exthdr.op;
> >  	new->exthdr.flags = expr->exthdr.flags;
> > +	new->exthdr.raw_type = expr->exthdr.raw_type;
> >  }
> >
> >  #define NFTNL_UDATA_EXTHDR_DESC 0
> > @@ -192,6 +201,7 @@ struct expr *exthdr_expr_alloc(const struct location *loc,
> >  	expr = expr_alloc(loc, EXPR_EXTHDR, tmpl->dtype,
> >  			  BYTEORDER_BIG_ENDIAN, tmpl->len);
> >  	expr->exthdr.desc = desc;
> > +	expr->exthdr.raw_type = desc ? desc->type : 0;
> >  	expr->exthdr.tmpl = tmpl;
> >  	expr->exthdr.offset = tmpl->offset;
> >  	return expr;
> > @@ -270,6 +280,8 @@ void exthdr_init_raw(struct expr *expr, uint8_t type,
> >  	unsigned int i;
> >
> >  	assert(expr->etype == EXPR_EXTHDR);
> > +	expr->exthdr.raw_type = type;
> > +
> >  	if (op == NFT_EXTHDR_OP_TCPOPT)
> >  		return tcpopt_init_raw(expr, type, offset, len, flags);
> >  	if (op == NFT_EXTHDR_OP_IPV4)
> > diff --git a/src/ipopt.c b/src/ipopt.c
> > index 7ecb8b9c8e32..5f9f908c0b34 100644
> > --- a/src/ipopt.c
> > +++ b/src/ipopt.c
> > @@ -103,6 +103,7 @@ struct expr *ipopt_expr_alloc(const struct location *loc, uint8_t type,
> >  	expr->exthdr.tmpl   = tmpl;
> >  	expr->exthdr.op     = NFT_EXTHDR_OP_IPV4;
> >  	expr->exthdr.offset = tmpl->offset + calc_offset(desc, tmpl, ptr);
> > +	expr->exthdr.raw_type = desc->type;
> >
> >  	return expr;
> >  }
> > diff --git a/src/netlink_linearize.c b/src/netlink_linearize.c
> > index a37e4b940973..05af8bb1b485 100644
> > --- a/src/netlink_linearize.c
> > +++ b/src/netlink_linearize.c
> > @@ -206,7 +206,7 @@ static void netlink_gen_exthdr(struct netlink_linearize_ctx *ctx,
> >  	nle = alloc_nft_expr("exthdr");
> >  	netlink_put_register(nle, NFTNL_EXPR_EXTHDR_DREG, dreg);
> >  	nftnl_expr_set_u8(nle, NFTNL_EXPR_EXTHDR_TYPE,
> > -			  expr->exthdr.desc->type);
> > +			  expr->exthdr.raw_type);
> >  	nftnl_expr_set_u32(nle, NFTNL_EXPR_EXTHDR_OFFSET, offset / BITS_PER_BYTE);
> >  	nftnl_expr_set_u32(nle, NFTNL_EXPR_EXTHDR_LEN,
> >  			   div_round_up(expr->len, BITS_PER_BYTE));
> > diff --git a/src/parser_bison.y b/src/parser_bison.y
> > index e8df98b8949a..393f66862810 100644
> > --- a/src/parser_bison.y
> > +++ b/src/parser_bison.y
> > @@ -5225,6 +5225,13 @@ tcp_hdr_option_type	:	EOL		{ $$ = TCPOPT_KIND_EOL; }
> >  			|	SACK3		{ $$ = TCPOPT_KIND_SACK3; }
> >  			|	ECHO		{ $$ = TCPOPT_KIND_ECHO; }
> >  			|	TIMESTAMP	{ $$ = TCPOPT_KIND_TIMESTAMP; }
> > +			|	NUM		{
> > +				if ($1 > 255) {
> > +					erec_queue(error(&@1, "value too large"), state->msgs);
> > +					YYERROR;
> > +				}
> > +				$$ = $1;
> > +			}
> >  			;
> >
> >  tcp_hdr_option_field	:	KIND		{ $$ = TCPOPT_COMMON_KIND; }
> > diff --git a/src/tcpopt.c b/src/tcpopt.c
> > index d1dd13b868e8..1cf97a563bc2 100644
> > --- a/src/tcpopt.c
> > +++ b/src/tcpopt.c
> > @@ -103,6 +103,19 @@ const struct exthdr_desc *tcpopt_protocols[] = {
> >  	[TCPOPT_KIND_TIMESTAMP]		= &tcpopt_timestamp,
> >  };
> >
> > +/**
> > + * tcpopt_expr_alloc - allocate tcp option extension expression
> > + *
> > + * @loc: location from parser
> > + * @kind: raw tcp option value to find in packet
> > + * @field: highlevel field to find in the option if @kind is present in packet
> > + *
> > + * Allocate a new tcp option expression.
> > + * @kind is the raw option value to find in the packet.
> > + * Exception: SACK may use extra OOB data that is mangled here.
> > + *
> > + * @field is the optional field to extract from the @type option.
> > + */
> >  struct expr *tcpopt_expr_alloc(const struct location *loc,
> >  			       unsigned int kind,
> >  			       unsigned int field)
> > @@ -138,8 +151,22 @@ struct expr *tcpopt_expr_alloc(const struct location *loc,
> >  	if (kind < array_size(tcpopt_protocols))
> >  		desc = tcpopt_protocols[kind];
> >
> > -	if (!desc)
> > -		return NULL;
> > +	if (!desc) {
> > +		if (field != TCPOPT_COMMON_KIND || kind > 255)
> > +			return NULL;
> > +
> > +		expr = expr_alloc(loc, EXPR_EXTHDR, &integer_type,
> > +				  BYTEORDER_BIG_ENDIAN, 8);
> > +
> > +		desc = tcpopt_protocols[TCPOPT_NOP];
> > +		tmpl = &desc->templates[field];
> > +		expr->exthdr.desc   = desc;
> > +		expr->exthdr.tmpl   = tmpl;
> > +		expr->exthdr.op = NFT_EXTHDR_OP_TCPOPT;
> > +		expr->exthdr.raw_type = kind;
> > +		return expr;
> > +	}
> > +
> >  	tmpl = &desc->templates[field];
> >  	if (!tmpl)
> >  		return NULL;
> > @@ -149,6 +176,7 @@ struct expr *tcpopt_expr_alloc(const struct location *loc,
> >  	expr->exthdr.desc   = desc;
> >  	expr->exthdr.tmpl   = tmpl;
> >  	expr->exthdr.op     = NFT_EXTHDR_OP_TCPOPT;
> > +	expr->exthdr.raw_type = desc->type;
> >  	expr->exthdr.offset = tmpl->offset;
> >
> >  	return expr;
> > @@ -165,6 +193,10 @@ void tcpopt_init_raw(struct expr *expr, uint8_t type, unsigned int off,
> >  	expr->len = len;
> >  	expr->exthdr.flags = flags;
> >  	expr->exthdr.offset = off;
> > +	expr->exthdr.op = NFT_EXTHDR_OP_TCPOPT;
> > +
> > +	if (flags & NFT_EXTHDR_F_PRESENT)
> > +		datatype_set(expr, &boolean_type);
> >
> >  	if (type >= array_size(tcpopt_protocols))
> >  		return;
> > @@ -178,12 +210,10 @@ void tcpopt_init_raw(struct expr *expr, uint8_t type, unsigned int off,
> >  		if (tmpl->offset != off || tmpl->len != len)
> >  			continue;
> >
> > -		if (flags & NFT_EXTHDR_F_PRESENT)
> > -			datatype_set(expr, &boolean_type);
> > -		else
> > +		if ((flags & NFT_EXTHDR_F_PRESENT) == 0)
> >  			datatype_set(expr, tmpl->dtype);
> > +
> >  		expr->exthdr.tmpl = tmpl;
> > -		expr->exthdr.op   = NFT_EXTHDR_OP_TCPOPT;
> >  		break;
> >  	}
> >  }
> > diff --git a/tests/py/any/tcpopt.t b/tests/py/any/tcpopt.t
> > index 1d42de8746cd..7b17014b3003 100644
> > --- a/tests/py/any/tcpopt.t
> > +++ b/tests/py/any/tcpopt.t
> > @@ -30,6 +30,7 @@ tcp option timestamp kind 1;ok
> >  tcp option timestamp length 1;ok
> >  tcp option timestamp tsval 1;ok
> >  tcp option timestamp tsecr 1;ok
> > +tcp option 255 missing;ok
> >
> >  tcp option foobar;fail
> >  tcp option foo bar;fail
> > @@ -38,6 +39,7 @@ tcp option eol left 1;fail
> >  tcp option eol left 1;fail
> >  tcp option sack window;fail
> >  tcp option sack window 1;fail
> > +tcp option 256 exists;fail
> >
> >  tcp option window exists;ok
> >  tcp option window missing;ok
> > diff --git a/tests/py/any/tcpopt.t.payload b/tests/py/any/tcpopt.t.payload
> > index 9c480c8bd06b..34f8e26c4409 100644
> > --- a/tests/py/any/tcpopt.t.payload
> > +++ b/tests/py/any/tcpopt.t.payload
> > @@ -509,20 +509,6 @@ inet
> >    [ exthdr load tcpopt 4b @ 8 + 2 => reg 1 ]
> >    [ cmp eq reg 1 0x01000000 ]
> >
> > -# tcp option timestamp tsecr 1
> > -ip
> > -  [ meta load l4proto => reg 1 ]
> > -  [ cmp eq reg 1 0x00000006 ]
> > -  [ exthdr load tcpopt 4b @ 8 + 6 => reg 1 ]
> > -  [ cmp eq reg 1 0x01000000 ]
> > -
> > -# tcp option timestamp tsecr 1
> > -ip6
> > -  [ meta load l4proto => reg 1 ]
> > -  [ cmp eq reg 1 0x00000006 ]
> > -  [ exthdr load tcpopt 4b @ 8 + 6 => reg 1 ]
> > -  [ cmp eq reg 1 0x01000000 ]
> > -
>
> You are removing unrelated duplicate payloads.  Is it worth doing that
> separately?

This seems to dedup' the payloads correctly:

  perl -nle '
    our @payload;
    our $rule;
    if (/^# (.+)/) {
      if ($rule ne $1) {
        print for @payload;
        $rule = $1
      }
      @payload = ()
    }
    push @payload, $_;
    END { print for @payload }
  ' tests/py/any/tcpopt.t.payload > tests/py/any/tcpopt.t.payload.tmp
  mv tests/py/any/tcpopt.t.payload.tmp tests/py/any/tcpopt.t.payload

One could use perl's -i switch, but the printing of the final payload
will be to stdout and not in-place.

> >  # tcp option timestamp tsecr 1
> >  inet
> >    [ meta load l4proto => reg 1 ]
> > @@ -530,19 +516,12 @@ inet
> >    [ exthdr load tcpopt 4b @ 8 + 6 => reg 1 ]
> >    [ cmp eq reg 1 0x01000000 ]
> >
> > -# tcp option window exists
> > -ip
> > -  [ meta load l4proto => reg 1 ]
> > -  [ cmp eq reg 1 0x00000006 ]
> > -  [ exthdr load tcpopt 1b @ 3 + 0 present => reg 1 ]
> > -  [ cmp eq reg 1 0x00000001 ]
> > -
> > -# tcp option window exists
> > -ip6
> > +# tcp option 255 missing
> > +inet
> >    [ meta load l4proto => reg 1 ]
> >    [ cmp eq reg 1 0x00000006 ]
> > -  [ exthdr load tcpopt 1b @ 3 + 0 present => reg 1 ]
> > -  [ cmp eq reg 1 0x00000001 ]
> > +  [ exthdr load tcpopt 1b @ 255 + 0 present => reg 1 ]
> > +  [ cmp eq reg 1 0x00000000 ]
> >
> >  # tcp option window exists
> >  inet
> > @@ -551,20 +530,6 @@ inet
> >    [ exthdr load tcpopt 1b @ 3 + 0 present => reg 1 ]
> >    [ cmp eq reg 1 0x00000001 ]
> >
> > -# tcp option window missing
> > -ip
> > -  [ meta load l4proto => reg 1 ]
> > -  [ cmp eq reg 1 0x00000006 ]
> > -  [ exthdr load tcpopt 1b @ 3 + 0 present => reg 1 ]
> > -  [ cmp eq reg 1 0x00000000 ]
> > -
> > -# tcp option window missing
> > -ip6
> > -  [ meta load l4proto => reg 1 ]
> > -  [ cmp eq reg 1 0x00000006 ]
> > -  [ exthdr load tcpopt 1b @ 3 + 0 present => reg 1 ]
> > -  [ cmp eq reg 1 0x00000000 ]
> > -
> >  # tcp option window missing
> >  inet
> >    [ meta load l4proto => reg 1 ]
> > @@ -572,16 +537,6 @@ inet
> >    [ exthdr load tcpopt 1b @ 3 + 0 present => reg 1 ]
> >    [ cmp eq reg 1 0x00000000 ]
> >
> > -# tcp option maxseg size set 1360
> > -ip
> > -  [ immediate reg 1 0x00005005 ]
> > -  [ exthdr write tcpopt reg 1 => 2b @ 2 + 2 ]
> > -
> > -# tcp option maxseg size set 1360
> > -ip6
> > -  [ immediate reg 1 0x00005005 ]
> > -  [ exthdr write tcpopt reg 1 => 2b @ 2 + 2 ]
> > -
> >  # tcp option maxseg size set 1360
> >  inet
> >    [ immediate reg 1 0x00005005 ]
> > --
> > 2.26.2
> >
> >



--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEd/6/sDFjb+OCRmRMonv1GCHZ79cFAl+kZ0YACgkQonv1GCHZ
79dJzgwAgvwfd766/4Wg2h9TtCdSwfIIBE+pfeFfjz3kHf+7JD0xSM/xMA6WfvOM
BbZLMXOUhF7+nF+g+e0wCAMTvz6BTrhdCr/ErnmsEfRFe21TKq3a52bRTagtiDbx
TFdljPPi7S+1Efi3QFRfXklly6LYrFjChDn3NTqYXoobJrLF7+dJywiyamO8bPI7
uxb0m52wUtyDeXCjgjp3SVnp/7MiZGkiOJe3Y4aP0VbQSIUY/QmG1RXDVRqnJthD
kQGOchR+zmJxuiWnfCUppnHzcpOpmNwYOSHxvY4fwzC6bG60TjRQBpd8JhRlIuNa
ySDmqt0J+Nd8Q0XoIVuOoPimpGBujMlOxT6GOSnXn2Zil7SzxGfCgW1k8A7IWzI1
gX7L4gS6/uX6x0/TFZbySMkwIX+5X9k4i7v4TzL87d15zp9qFBUWIskmiNwL75rT
ShO4KopszvfNuIrx64I+lj+gQCT5giRF88rsf9nqS1QQlvM8XCMlphUiLJFHa/LS
LfLMBJwJ
=69LW
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--
