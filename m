Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA6159BE1F
	for <lists+netfilter-devel@lfdr.de>; Sat, 24 Aug 2019 16:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfHXOHf (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 24 Aug 2019 10:07:35 -0400
Received: from vxsys-smtpclusterma-02.srv.cat ([46.16.60.192]:49081 "EHLO
        vxsys-smtpclusterma-02.srv.cat" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727440AbfHXOHf (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 24 Aug 2019 10:07:35 -0400
Received: from [192.168.0.22] (static-79-171-230-77.ipcom.comunitel.net [77.230.171.79])
        by vxsys-smtpclusterma-02.srv.cat (Postfix) with ESMTPSA id 4B83522D5B;
        Sat, 24 Aug 2019 16:07:31 +0200 (CEST)
Subject: Re: [PATCH nft v8 2/2] meta: Introduce new conditions 'time', 'day'
 and 'hour'
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
References: <20190821151802.6849-1-a@juaristi.eus>
 <20190821151802.6849-2-a@juaristi.eus> <20190821162341.GB20113@breakpoint.cc>
 <20190821205055.dss3wfiv4pogyhjl@salvia>
 <20190821210417.GD20113@breakpoint.cc>
 <f7b2dec4-d58e-e65b-296a-11061b4af90f@juaristi.eus>
 <20190823123917.uxdlb7gzfbgamfxc@salvia>
From:   Ander Juaristi <a@juaristi.eus>
Message-ID: <1662584b-3839-ce3b-bc46-8e21f4a8d146@juaristi.eus>
Date:   Sat, 24 Aug 2019 16:07:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823123917.uxdlb7gzfbgamfxc@salvia>
Content-Type: multipart/mixed;
 boundary="------------51234BFE88D46F2B7A9222BF"
Content-Language: en-US
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This is a multi-part message in MIME format.
--------------51234BFE88D46F2B7A9222BF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23/8/19 14:39, Pablo Neira Ayuso wrote:
>=20
> Phil likes having fine grain knobs. I (as a user) particularly prefer
> the global -n switch, but I also see value in those fine grain knobs.
>=20
> Anyway, I let you choose on this one.

I've decided to keep it, but I've changed it's long name to
'--numeric-time'.

    +"  -t, --numeric-time          Print time values numerically (time,
day, hour).\n"


I think it better captures the intent and it's in line with other
--numeric-XXXX options.

In addition, -n also includes the behavior of -t.

I've just sent v9.

--------------51234BFE88D46F2B7A9222BF
Content-Type: application/pgp-keys;
 name="pEpkey.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="pEpkey.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
uJnKmDCTU3EjmLMmBF1HhrAqfWklCjZHAl4LdXY=3D
=3DXX5J
-----END PGP PUBLIC KEY BLOCK-----

--------------51234BFE88D46F2B7A9222BF--
