Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498F220233C
	for <lists+netfilter-devel@lfdr.de>; Sat, 20 Jun 2020 12:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgFTKex (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 20 Jun 2020 06:34:53 -0400
Received: from dehost.average.org ([88.198.2.197]:51272 "EHLO
        dehost.average.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbgFTKeu (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 20 Jun 2020 06:34:50 -0400
Received: from [IPv6:2a02:8106:1:6800::640] (unknown [IPv6:2a02:8106:1:6800::640])
        by dehost.average.org (Postfix) with ESMTPSA id A5D57354C085;
        Sat, 20 Jun 2020 12:34:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=average.org; s=mail;
        t=1592649286; bh=G5JzrYOUTDRp3NeWWOJlN3riXNYkBepyN4Jj4K/bhhY=;
        h=To:Cc:References:From:Subject:Date:In-Reply-To:From;
        b=ajNDmkR2puWYyjya38mmrX/6oc5qD+SopCofJoSIeMdFGa+Cpe6w7AomGRVHRO7wY
         QWefotvsZ7JbYaVepYcn0uYOU7S9OtkTzdGQWZntwDTEHlaFbrLtwjIHVnP6pfflTW
         zU1X8z7Pld/JgL+fkAHxp5B5mCSIFWoXwUxiYT9c=
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Jan Engelhardt <jengelh@inai.de>, netfilter-devel@vger.kernel.org
References: <76cd59a3-6403-9408-1b8c-af5f11d5fa85@average.org>
 <nycvar.YFH.7.77.849.2006161717590.16107@n3.vanv.qr>
 <1566db8a-00d4-d9de-8c3d-6625fe2149fa@average.org>
 <nycvar.YFH.7.77.849.2006161830320.16707@n3.vanv.qr>
 <874fd8a8-dfd2-f6c3-ae01-61884ca9bcff@average.org>
 <20200619151530.GA3894@salvia>
From:   Eugene Crosser <crosser@average.org>
Autocrypt: addr=crosser@average.org; prefer-encrypt=mutual; keydata=
 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
Subject: Expose skb_gso_validate_network_len() [Was: ebtables: load-on-demand
 extensions]
Message-ID: <13977ee9-d93b-62fd-c86a-6c4466f63e38@average.org>
Date:   Sat, 20 Jun 2020 12:34:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200619151530.GA3894@salvia>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ddRyZgoXNSqgH6m1gI2kVxEgoMCFJN9t3"
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ddRyZgoXNSqgH6m1gI2kVxEgoMCFJN9t3
Content-Type: multipart/mixed; boundary="vv5uLepI7PHSgZU1bs1MAGOwkS380Zsh6";
 protected-headers="v1"
From: Eugene Crosser <crosser@average.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jan Engelhardt <jengelh@inai.de>, netfilter-devel@vger.kernel.org
Message-ID: <13977ee9-d93b-62fd-c86a-6c4466f63e38@average.org>
Subject: Expose skb_gso_validate_network_len() [Was: ebtables: load-on-demand
 extensions]
References: <76cd59a3-6403-9408-1b8c-af5f11d5fa85@average.org>
 <nycvar.YFH.7.77.849.2006161717590.16107@n3.vanv.qr>
 <1566db8a-00d4-d9de-8c3d-6625fe2149fa@average.org>
 <nycvar.YFH.7.77.849.2006161830320.16707@n3.vanv.qr>
 <874fd8a8-dfd2-f6c3-ae01-61884ca9bcff@average.org>
 <20200619151530.GA3894@salvia>
In-Reply-To: <20200619151530.GA3894@salvia>

--vv5uLepI7PHSgZU1bs1MAGOwkS380Zsh6
Content-Type: text/plain; charset=koi8-r
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 19/06/2020 17:15, Pablo Neira Ayuso wrote:
>>>>> Why not make a patch to publicly expose the skb's data via nft_meta=
?
>>>>> No more custom modules, no more userspace modifications [..]
>>>>
>>>> For our particular use case, we are running the skb through the kern=
el
>>>> function `skb_validate_network_len()` with custom mtu size [..]

(the function name is skb_gso_validate_network_len, my mistake)

I previously expressed strong opinion that our "hack" to send icmp reject=
s on
Layer 2 will not be useful for anyone else. But the existence of the comm=
it from
Michael Braun proves that I was wrong, and Jan Engelhards was right: it p=
robably
makes sense to implement the functionality that we need within the "new" =
nft
infrastructure.

As far as I understand, the part that is missing in the existing implemen=
tation
is exposure (in some form) of `skb_gso_validate_network_len()` function t=
o
user-configurable filters. Because the kernel does now expose the _size_ =
under
which a gso skb can be segmented, but only the _boolean_ with the meaning=
 "this
gso skb can fit in mtu that you've specified", I could envision a new mat=
ch that
could be named like "fits-in-mtu-size" or "segmentable-under". Then an nf=
tables
rule could look roughly like this (for ipv4):

    nft insert rule bridge filter FORWARD \
      ip frag-off & 0x4000 !=3D 0 \
      ip protocol tcp \
      not tcp segmentable-under 1400 \
      reject with icmp type frag-needed

This new function would act the same as "ip len < XXX" for non-gso skbs, =
and
call skb_gso_validate_network_len(skb, XXX) for gso skbs.

Do you think it makes sense? Shall I try to implement this and submit a p=
atch?

Thank you,

Eugene

>>> I find no such function in the current or past kernels. Perhaps you c=
ould post
>>> the code of the module(s) you already have, and we can assess if it, =
or the
>>> upstream ideals, can be massaged to make the code stick.
>>
>> I really really don't see our module being useful for anyone else! Eve=
n
>> for us, it's just a stopgap measure, hopefully to be dropped after a f=
ew
>> months. That said, I believe that the company will have no objections
>> against publishing it. I've uploaded initial (untested) code on github=

>> here https://github.com/crosser/ebt-pmtud, in case anyone is intereste=
d.
>=20
> I think there is a way to achieve this with nft 0.9.6 ?
>=20
> commit 2a20b5bdbde8a1b510f75b1522772b07e51a77d7
> Author: Michael Braun <...>
> Date:   Wed May 6 11:46:23 2020 +0200
>=20
>     datatype: add frag-needed (ipv4) to reject options
>=20
>     This enables to send icmp frag-needed messages using reject target.=

>=20
>     I have a bridge with connects an gretap tunnel with some ethernet l=
an.
>     On the gretap device I use ignore-df to avoid packets being lost wi=
thout
>     icmp reject to the sender of the bridged packet.
>=20
>     Still I want to avoid packet fragmentation with the gretap packets.=

>     So I though about adding an nftables rule like this:
>=20
>     nft insert rule bridge filter FORWARD \
>       ip protocol tcp \
>       ip length > 1400 \
>       ip frag-off & 0x4000 !=3D 0 \
>       reject with icmp type frag-needed
>=20
>     This would reject all tcp packets with ip dont-fragment bit set tha=
t are
>     bigger than some threshold (here 1400 bytes). The sender would then=
 receive
>     ICMP unreachable - fragmentation needed and reduce its packet size =
(as
>     defined with PMTU).
>=20



--vv5uLepI7PHSgZU1bs1MAGOwkS380Zsh6--

--ddRyZgoXNSqgH6m1gI2kVxEgoMCFJN9t3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEnAziRJw3ydIzIkaHfKQHw5GdRYwFAl7t5kIACgkQfKQHw5Gd
RYzGWQf/cMmuARcLcSCfqlyBVGn5G01HYBeLFEegLoQAWyJpt6yEvMJ/NbUfj/37
6x6AdbPxKb/tsGMDeeADtesoeACEvqNPmmO2bj3x2GHYLhrrzmOhSmP1CPtXelWx
+oQYUMrfLfWPUA8H5dz+mmHqVZMv6Tt5IfhJ6yOxsbx//KwnZZ3zXIQel7WQxC/X
sb3xyFfEHDirbYzV+zxnbzEerph6qjqktO7ZZLGYKTefZaF5zW8bs7DsrHIWkXEB
eWgGKXJJh0SANGrGowqXb9+ZTf4E6NPexnNTcobW5VH0wv/1yw5Qfx5UtQPk+ibS
q6ohsI00b3UhMvQvyPJUGf9233MyTw==
=0dYa
-----END PGP SIGNATURE-----

--ddRyZgoXNSqgH6m1gI2kVxEgoMCFJN9t3--
