Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3431E113D6A
	for <lists+netfilter-devel@lfdr.de>; Thu,  5 Dec 2019 09:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfLEI44 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 5 Dec 2019 03:56:56 -0500
Received: from kadath.azazel.net ([81.187.231.250]:49068 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbfLEI4z (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 5 Dec 2019 03:56:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=flEWGwzL3HspGV8X2aIZD7PyH/ZQHQEljVYIfQkUnVg=; b=ZExKU+sJpWfIc9aKX2A07x4qoH
        X0eP4vB0+nMaHdScd0+7tQnruzRtIUQewgwqJDiXFhQyTM4ryfRBQYjs03HiDjCJbOiYKJYpGFIlN
        06U4ZL+KEa8nGN1V3PuNO5gzB2KFYp4B3BPzIlg0+Ic9s24uXIXJjJvDkD/6NecBZ8iureSRC38Rz
        tLs3XsqlelkkpfAUOJWhgv4num3uBmbJce5KeHYMC2mL87huFtVinR2F2wAdIHHOpQrTw1+A9LIeF
        YS+8TRty8kicD20E00QQkpaD9dcF2BFOXdv6GGNGZwb1jG8AI8mluTQ85+XUxRd/WLqlru7CJOaBK
        ZN4UE2ig==;
Received: from celephais.dreamlands ([192.168.96.3] helo=azazel.net)
        by kadath.azazel.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1icmwO-0008PA-Ss; Thu, 05 Dec 2019 08:56:52 +0000
Date:   Thu, 5 Dec 2019 08:56:57 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Kevin Darbyshire-Bryant <ldir@darbyshire-bryant.me.uk>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 0/1] netfilter: connmark: introduce set-dscpmark
Message-ID: <20191205085657.GF133447@azazel.net>
References: <20190324142314.92539-1-ldir@darbyshire-bryant.me.uk>
 <20191203160652.44396-1-ldir@darbyshire-bryant.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z0eOaCaDLjvTGF2l"
Content-Disposition: inline
In-Reply-To: <20191203160652.44396-1-ldir@darbyshire-bryant.me.uk>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-SA-Exim-Connect-IP: 192.168.96.3
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


--z0eOaCaDLjvTGF2l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 2019-12-03, at 16:06:52 +0000, Kevin Darbyshire-Bryant wrote:
> Greetings.  The following patch is similar to one I submitted as an
> RFC quite a while back (April).  Since then I've realised that the
> option should have been in the 'set mark' family as opposed to 'save
> mark' because 'set' is about setting the ct mark directly, whereas
> 'save' is about copying a packet's mark to the ct mark.
>
> Similarly I've been made aware of the revision infrastructure and now
> that I understand that a little more have made use of it for this
> change.  Hopefully this addresses one of Pablo's concerns.
>
> I've not been able to address the 'I'd like an nftables version'.
> Quite simply it is beyond my knowledge and ability.  I am willing to
> contribute financially if someone wishes to step up to the nftables
> plate...yes I'd like to see the functionality implemented *that* much.

I'll do it (no financial contribution required :)). There is one thing I
want to find out before I get started.

Pablo, comparing the x_tables and nftables connmark implementations I
see that nftables doesn't support all the bit-twiddling that x_tables
does.  Why is this?  Was it not wanted or has it just not been imple-
mented?

J.

--z0eOaCaDLjvTGF2l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEZ8d+2N/NBLDbUxIF0Z7UzfnX9sMFAl3oxlIACgkQ0Z7UzfnX
9sPg1Q//b6yJt1+Hbh85MH6MkvDRUNmxAxK8GJvgT2la5ZVC62V7NqkbQEvCRgLC
NF90lbeXDpmmPBzitLpum00WEweDwlmgGy+h/UOS40Fa8lN64yq3dwIWV675s9IP
O8y6qoyA3eHZixIOz/bs1qM2jKDa2yWpml4jbtnjGCE0j6o5Un+CWX5GxitOXbFx
senbinjOp3519jjrTr6B/NWu87TSfutiGt/IJTLuMJxsodnnJTlQMsWpTR1WREtc
sKqRG3u7K109ELneqDvzfNuLFiLAoambz3yh2wk/thXLa2ZujX3ngNpZmpv85UNR
CoBXFNl5JJ482TLq9gOzFYS6npA2Um49NUnynbnzqbMv/kfLf0kyTkJlGtBPAc6Z
IgJCgmQHuZsR15YKxBJFBkL/O+R1JVmiOC8MWvN69XRd/ybuG0Ua76AfnWHaiNWA
CYTF9kEU40Ej7oEb8QBcva6y0pn2ioeCGh9ycD/Qwinbum+mrTCc+qkzG0yCOgnS
JPLEgw4kwaMRz/vYPv7ub1oVOr8FAYYY9zkBqQmh1nDaawg2paaE0Erc7mZUVT83
w1dGjEPzgNKV6RaYZg+JUDfichJTPgWeGM5D/BPScvPikzH1MW1R9xdPuGWmi2Np
NoooBUlXce9523abKipfXNrMwuO+5w1+EctsqCEZdTYmFNIL8jk=
=ass7
-----END PGP SIGNATURE-----

--z0eOaCaDLjvTGF2l--
