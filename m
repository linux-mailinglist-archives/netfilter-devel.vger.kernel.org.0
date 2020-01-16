Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7D4F13D9B2
	for <lists+netfilter-devel@lfdr.de>; Thu, 16 Jan 2020 13:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgAPMNI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 16 Jan 2020 07:13:08 -0500
Received: from kadath.azazel.net ([81.187.231.250]:34238 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbgAPMNI (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 16 Jan 2020 07:13:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=E+OzyMHuMaBPnXANpgnLkW7GgDfrHEdn2EHMEpqvamA=; b=GkVfZLJh6km58tEA3KxYxjQq7g
        E7viF/jJZbPxd3z72BWhD1Dt7KQ4LHrWGcCYIKcW1R9hODlwlX0//2bnTjCArFsweU4xulFAkOucN
        dOugGbRMW0wCi1lV2fleHZfeQ6Ej2r6FPgPACDM09c1KwGRRo1Cd5hKgrjpwUHYvHYR9RRmovJ4RA
        kVCBXdHAkcuPXn0xp8fbmGi9IUa8E6/WKBmJD9AARpTC4jvDXA9FGpq/NH+oSmq3YGto1HHdm7FDK
        qclhrJLXt9BHMBHQsDSel3SMjPjfhN7tB0U8pvje13dBnzFmtl7lIO+rTJqOfZFIOU9QkqOB/O8JI
        xGtb2TeA==;
Received: from pnakotus.dreamlands ([192.168.96.5] helo=azazel.net)
        by kadath.azazel.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1is41L-0008Ix-9Y; Thu, 16 Jan 2020 12:13:07 +0000
Date:   Thu, 16 Jan 2020 12:13:07 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nf-next v4 00/10] netfilter: nft_bitwise: shift support
Message-ID: <20200116121307.GB18463@azazel.net>
References: <20200115213216.77493-1-jeremy@azazel.net>
 <20200116085133.GG999973@azazel.net>
 <20200116112247.pfhkhii6b44iiw3n@salvia>
 <20200116114152.GA18463@azazel.net>
 <20200116120925.eztbab76355ltdpe@salvia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline
In-Reply-To: <20200116120925.eztbab76355ltdpe@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 192.168.96.5
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 2020-01-16, at 13:09:25 +0100, Pablo Neira Ayuso wrote:
> On Thu, Jan 16, 2020 at 11:41:53AM +0000, Jeremy Sowden wrote:
> > On 2020-01-16, at 12:22:47 +0100, Pablo Neira Ayuso wrote:
> > > On Thu, Jan 16, 2020 at 08:51:33AM +0000, Jeremy Sowden wrote:
> > > > On 2020-01-15, at 21:32:06 +0000, Jeremy Sowden wrote:
> > > > > The connmark xtables extension supports bit-shifts.  Add support
> > > > > for shifts to nft_bitwise in order to allow nftables to do
> > > > > likewise, e.g.:
> > > > >
> > > > >   nft add rule t c oif lo ct mark set meta mark << 8 | 0xab
> > > > >   nft add rule t c iif lo meta mark & 0xff 0xab ct mark set meta mark >> 8
> > > > >
> > > > > Changes since v3:
> > > > >
> > > > >   * the length of shift values sent by nft may be less than
> > > > >   sizeof(u32).
> > > >
> > > > Actually, having thought about this some more, I believe I had it
> > > > right in v3.  The difference between v3 and v4 is this:
> > > >
> > > >   @@ -146,7 +146,7 @@ static int nft_bitwise_init_shift(struct nft_bitwise *priv,
> > > >                               tb[NFTA_BITWISE_DATA]);
> > > >           if (err < 0)
> > > >                   return err;
> > > >   -       if (d.type != NFT_DATA_VALUE || d.len != sizeof(u32) ||
> > > >   +       if (d.type != NFT_DATA_VALUE || d.len > sizeof(u32) ||
> > > >               priv->data.data[0] >= BITS_PER_TYPE(u32)) {
> > >
> > > Why restrict this to 32-bits?
> >
> > Because of how I implemented the shifts.  Here's the current rshift:
> >
> >   static void nft_bitwise_eval_rshift(u32 *dst, const u32 *src,
> >                                       const struct nft_bitwise *priv)
> >   {
> >           u32 shift = priv->data.data[0];
> >           unsigned int i;
> >           u32 carry = 0;
> >
> >           for (i = 0; i < DIV_ROUND_UP(priv->len, sizeof(u32)); i++) {
> >                   dst[i] = carry | (src[i] >> shift);
> >                   carry = src[i] << (BITS_PER_TYPE(u32) - shift);
> >           }
> >   }
> >
> > In order to support larger shifts, it would need to look something
> > like:
>
> No need for larger shift indeed, no need for this.
>
> I just wanted to make sure NFTA_BITWISE_DATA can be reused later on in
> future new operation that might require larger data.
>
> All good then, I'll review v3, OK?

Yup. :)

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEd/6/sDFjb+OCRmRMonv1GCHZ79cFAl4gU08ACgkQonv1GCHZ
79cWKgv/cR9zttVZ+p0Fe7CXml8xx8GwAl8RXRfdh/Fkum73ry1zjXiljgutcNyC
NOnaSu1oq5oT20d33btdGEcqoym9ugHvqSPvV/PFNBQusZsnsN/8dOWe2RkVAur5
YkuHc+3rg5XK6uRsl8hcnnGnwywI1McJABNGmYGtPgSsLwBgUYV9OuVftHvghNCi
X4f5WnAa1CCbn4s2UkiLCYHikNuMLKxj2h8Q5NynzyOk1HNEoT/7uIS2uC0zUQ7B
4VEcgXmzzGYLC1hEt4hruFvTFZR6ENYXx6MUieQhnud6qRBiLsZXkgUp379mDL8x
4T4rcaJO9fYJNWCEik8ED25ys5oyJf9h+NoBtZ9WL0fupLCrl+bpNOY6XOI2Oddc
XBRwMxCW1CVCjwB26mVY1ZZLQAmbbWjUTTFY9Uz2I54flmXMBJjNnDeHdVfdX05G
vcIV7kFtrYbceiYNTVTr+CmRnBZI8FwKCDqBw9kXW31mnkkQr5Km0DTkOj9GNarM
AFVW2elA
=8p+F
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--
