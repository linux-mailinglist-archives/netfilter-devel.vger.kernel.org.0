Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECF5398498
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Aug 2019 21:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfHUTfM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 21 Aug 2019 15:35:12 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:31034 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729790AbfHUTfM (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1566416110;
        s=strato-dkim-0002; d=fami-braun.de;
        h=Message-ID:Subject:To:From:Date:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=pLx6U4A06AJtAH7iE3KycFaGRMAYmmLH2DgDpqHRPQs=;
        b=IX/hv6ziubH1YQhx+f5H6qHiw2x2YUDvE/hDXH5nBGx/TH9T5lZ4S/NzsSq1Yd60Yd
        DGJjB/hppIOWZCjeHoMePtMfOLBY29qURuRScLTF+8UmQT+IisKDLWWisd805e3RNQsn
        IMuuYTTKGAKFuRH1ccGQohnlZ7Xchy28VW2WGUPbXJGVVq0OzazBFzJ/Nx1/W/IGhdhs
        3EeIF0Pr5y/7MAmRAx1OoytB741Z5qLWvDN/Th3bc9ArUe9hMAonlxnX37ItsshNGv+F
        vEpCD4GCiGRCr4LFOwaZ6sAWCu+f/BWZpyd5W6cnW3dOAYmQaKNeuM8xb9gYE2KiDQaK
        kFsQ==
X-RZG-AUTH: ":P20JeEWkefDI1ODZs1HHtgV3eF0OpFsRaGIBEm4ljegySSvO7VhbcRIBGrxpcA5nVfJ6oTd1q4jkuxsHZDcOZDEe4UScZJh+bHNcZcPNlr35aw=="
X-RZG-CLASS-ID: mo00
Received: from dynamic.fami-braun.de
        by smtp.strato.de (RZmta 44.26.1 AUTH)
        with ESMTPSA id J0927dv7LJT7hKq
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate)
        for <netfilter-devel@vger.kernel.org>;
        Wed, 21 Aug 2019 21:29:07 +0200 (CEST)
Received: from dynamic.fami-braun.de (localhost [127.0.0.1])
        by dynamic.fami-braun.de (fami-braun.de) with ESMTP id 29BED15409A
        for <netfilter-devel@vger.kernel.org>; Wed, 21 Aug 2019 21:29:07 +0200 (CEST)
Received: from
 yLVXouRt4dVn2cPyEcN+JbkHTgc9yR3C9RoCRk82pVa1nJ3rDYF4DsfZ+LFsHh1U
 (1Frz78cJO3RrTCAy9ByEU/jK2uMm8fWf)
 by webmail.fami-braun.de
 with HTTP (HTTP/1.1 POST); Wed, 21 Aug 2019 21:29:00 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 21 Aug 2019 21:29:00 +0200
From:   michael-dev <michael-dev@fami-braun.de>
To:     netfilter-devel@vger.kernel.org
Subject: nftables matching gratuitous arp
Message-ID: <c81c933d181adbfdad94057569501d35@fami-braun.de>
X-Sender: michael-dev@fami-braun.de
User-Agent: Roundcube Webmail/1.3.6
X-Virus-Scanned: clamav-milter 0.101.2 at gate
X-Virus-Status: Clean
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on gate.zuhause.all
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

I'm trying to match gratuitous arp with nftables. I've tried
> nft add rule bridge filter somechain arp saddr ip == arp daddr ip

but nft (some commits before 0.9.2) says:
> Error: syntax error, unexpected daddr, expecting end of file or newline 
> or semicolon
> add rule bridge filter FORWARD arp saddr ip == arp daddr ip
                                                    ^^^^^
Looking at the description of the netlink protocol, it looks like two 
loads and a cmp of both registers would do it.

Am I'm correct that this is currently not possible with nft, so a patch 
to nft would be needed?

Thanks,
M. Braun
