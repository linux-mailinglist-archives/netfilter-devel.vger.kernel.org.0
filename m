Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6438ED8231
	for <lists+netfilter-devel@lfdr.de>; Tue, 15 Oct 2019 23:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbfJOV3V (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 15 Oct 2019 17:29:21 -0400
Received: from kadath.azazel.net ([81.187.231.250]:39686 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfJOV3V (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 15 Oct 2019 17:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=RU+xsFzG34NWigj6zr/m24w2ipqp1F+RcxJBHQPWfCY=; b=fUGkIcfautXteCAV8eOAcpBAVs
        913LNuqLiREsGY2gCM9X53vGCquE/YY276AyZ4CCashH5aLjFQA/KX0ofNCIEGOGoUzoSeXxSz6oj
        by9iU0cg00GehpJb7fjPSSXQayrFEeNNcl3WGENTj5m8EVIRwXFR3HZek/oHwojexlj76oJHz1ZIK
        YscXbGM7lJmJd+dIzKXDv0SHTTsXScIQgpzNbHN5aH1rmWak285npoPwrsGE3LnM2SuZ7PqMbXB8F
        B7Kn9aHIvqgzEXtq8Tjj9bimXgQeoNf2GRfPzprqhMoCFBI3iZp7ZK00q72puAlLCHxg7jJBzbOYy
        HNTqPoMQ==;
Received: from celephais.dreamlands ([192.168.96.3] helo=azazel.net)
        by kadath.azazel.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1iKUNb-0005k1-Bc; Tue, 15 Oct 2019 22:29:19 +0100
Date:   Tue, 15 Oct 2019 22:29:18 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next] netfilter: ctnetlink: don't dump ct extensions
 of unconfirmed conntracks
Message-ID: <20191015212917.GA12740@azazel.net>
References: <20191014194141.17626-1-fw@strlen.de>
 <20191015210647.GA16877@azazel.net>
 <20191015212204.GR25052@breakpoint.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <20191015212204.GR25052@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 192.168.96.3
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 2019-10-15, at 23:22:04 +0200, Florian Westphal wrote:
> Jeremy Sowden wrote:
> > On 2019-10-14, at 21:41:41 +0200, Florian Westphal wrote:
> > > When dumping the unconfirmed lists, the cpu that is processing the
> > > ct entry can realloc ct->ext at any time.
> > >
> > > Accessing extensions from another CPU is ok provided rcu read lock
> > > is held.
> > >
> > > Once extension space will be reallocated with plain krealloc this
> > > isn't used anymore.
> > >
> > > Dumping the extension area for confirmed or dying conntracks is
> > > fine: no reallocations are allowed and list iteration holds
> > > appropriate locks that prevent ct (and thus ct->ext) from getting
> > > free'd.
> > >
> > > Signed-off-by: Florian Westphal <fw@strlen.de>
> > > ---
> > >  net/netfilter/nf_conntrack_netlink.c | 77 ++++++++++++++++++----------
> > >  1 file changed, 51 insertions(+), 26 deletions(-)
> > >
> > > diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
> > > index e2d13cd18875..db04e1bfb04d 100644
> > > --- a/net/netfilter/nf_conntrack_netlink.c
> > > +++ b/net/netfilter/nf_conntrack_netlink.c
> > > @@ -506,9 +506,44 @@ static int ctnetlink_dump_use(struct sk_buff *skb, const struct nf_conn *ct)
> > >  	return -1;
> > >  }
> > >
> > > +/* all these functions access ct->ext. Caller must either hold a reference
> > > + * on ct or prevent its deletion by holding either the bucket spinlock or
> > > + * pcpu dying list lock.
> > > + */
> > > +static int ctnetlink_dump_extinfo(struct sk_buff *skb,
> > > +				  const struct nf_conn *ct, u32 type)
> > > +{
> > > +	if (ctnetlink_dump_acct(skb, ct, type) < 0 ||
> > > +	    ctnetlink_dump_timestamp(skb, ct) < 0 ||
> > > +	    ctnetlink_dump_helpinfo(skb, ct) < 0 ||
> > > +	    ctnetlink_dump_labels(skb, ct) < 0 ||
> > > +	    ctnetlink_dump_ct_seq_adj(skb, ct) < 0 ||
> > > +	    ctnetlink_dump_ct_synproxy(skb, ct) < 0)
> > > +		return -1;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int ctnetlink_dump_info(struct sk_buff *skb, struct nf_conn *ct)
> > > +{
> > > +	if (ctnetlink_dump_status(skb, ct) < 0 ||
> > > +	    ctnetlink_dump_mark(skb, ct) < 0 ||
> > > +	    ctnetlink_dump_secctx(skb, ct) < 0 ||
> > > +	    ctnetlink_dump_id(skb, ct) < 0 ||
> > > +	    ctnetlink_dump_use(skb, ct) < 0 ||
> > > +	    ctnetlink_dump_master(skb, ct) < 0)
> > > +		return -1;
> > > +
> > > +	if (!test_bit(IPS_OFFLOAD_BIT, &ct->status) &&
> > > +	    (ctnetlink_dump_timeout(skb, ct) < 0 ||
> > > +	     ctnetlink_dump_protoinfo(skb, ct) < 0))
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static int
> > >  ctnetlink_fill_info(struct sk_buff *skb, u32 portid, u32 seq, u32 type,
> > > -		    struct nf_conn *ct)
> > > +		    struct nf_conn *ct, bool extinfo)
>
> [..]
>
> > > +
> > > +			/* We can't dump extension info for the unconfirmed
> > > +			 * list because unconfirmed conntracks can have ct->ext
> > > +			 * reallocated (and thus freed).
> > > +			 *
> > > +			 * In the dying list case ct->ext can't be altered during
> > > +			 * list walk anymore, and free can only occur after ct
> > > +			 * has been unlinked from the dying list (which can't
> > > +			 * happen until after we drop pcpu->lock).
> > > +			 */
> > >  			res = ctnetlink_fill_info(skb, NETLINK_CB(cb->skb).portid,
> > >  						  cb->nlh->nlmsg_seq,
> > >  						  NFNL_MSG_TYPE(cb->nlh->nlmsg_type),
> > > -						  ct);
> > > -			rcu_read_unlock();
> > > +						  ct, dying ? true : false);
> >
> > s/dying ? true : false/dying/
>
> Yes, but it found it misleading since the last argument isn't about
> 'dying' or not, it tells that we can safely access ct->ext.

Fair enough.  Read in the context of a patch, it just looks
tautological.

J.

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEZ8d+2N/NBLDbUxIF0Z7UzfnX9sMFAl2mOiUACgkQ0Z7UzfnX
9sPQ5hAAk49gLfcYO2ZtF52/+w77g9Msmn6925HIc61tXmZM3yAv5Q6JkiV9vPpb
MtyTz13ddAyOzMSQj3T6z5Y9O0gr7Ayki+gFfBNj1J5Rz61l8gl52HRteyVS4Tz4
Por8bScNaP9KTiWIZKrKw6GCCjhCkubs/gvLFMWE8kcSoJc3nWR7KJ6JsXvyOK+6
/7v7FvqheHyf0XKSSpdT5N7l3nfm4S/poJLHzMeMQGXn2ON9qvjcoyjWKC4+KDoR
hQaeYkcvVQ/rEbMyZHmnaD/1jdFh6L652hg8kUPTXl8wOn6pUTOY3mFM+PK7prqX
UN8CwSmWwsBK4mJDIB58mtn3LX4SXyRfGFGxhWYrqUntgZ63oRqzgbIQw5vUO4qR
Puo+1fHZrQMpDgCGP+O/HYlpnvbk5f+KiZ+0QvRtiEkwSI5cyzyN7fUrjKSU2uMp
Kb430jonmrOBEWnH3XepDK5o5yqd9Pdcs3EpBqkPqfSSfmTJhN+9lJGsVGsOtSra
Nbi5FfMv1IOXTQAacwtwC5qToaMRLScM03jbTjeJLQi3u4STJtGLrWuf1ww4Mnpt
zuvv+TsbxmOfzyxXrrfnn0CQYa2/ZJKuZCEOUZXHhxgeBKG2xNgOiFVZQGrc59BM
tZu7Edey93wZJe5y4ATwrB08EktGUag/Sl452Xj9SHfi7NwQOvg=
=e40G
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
