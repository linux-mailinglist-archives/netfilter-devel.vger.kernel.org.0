Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82ADCEAE9C
	for <lists+netfilter-devel@lfdr.de>; Thu, 31 Oct 2019 12:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfJaLRq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 31 Oct 2019 07:17:46 -0400
Received: from smtp-out.kfki.hu ([148.6.0.46]:48825 "EHLO smtp-out.kfki.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbfJaLRq (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:17:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp1.kfki.hu (Postfix) with ESMTP id 8C5563C80120;
        Thu, 31 Oct 2019 12:17:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        blackhole.kfki.hu; h=mime-version:user-agent:references
        :message-id:in-reply-to:from:from:date:date:received:received
        :received; s=20151130; t=1572520662; x=1574335063; bh=RgMgN//q3V
        V7JLcSZDSyEc27ad90ly+/2QF3xPSH1kQ=; b=l6NN3GZeRnBr2hSjPR+f5zgstU
        wbC5y8NURubyYuWgQBSIKxmHaO4A8QIHcEuuGaoED30DnJJJnFoZDFZbGsl5NpD5
        KQd3Jngr8rOHPbbepgIlSVjqm4pHXuMxu8t+iv8Y3TW2uZc26ZV0h4lzd1R9NWVG
        hoB5QhULhjJa5vehc=
X-Virus-Scanned: Debian amavisd-new at smtp1.kfki.hu
Received: from smtp1.kfki.hu ([127.0.0.1])
        by localhost (smtp1.kfki.hu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP; Thu, 31 Oct 2019 12:17:42 +0100 (CET)
Received: from blackhole.kfki.hu (blackhole.szhk.kfki.hu [IPv6:2001:738:5001:1::240:2])
        by smtp1.kfki.hu (Postfix) with ESMTP id 297843C800F8;
        Thu, 31 Oct 2019 12:17:42 +0100 (CET)
Received: by blackhole.kfki.hu (Postfix, from userid 1000)
        id 0593620267; Thu, 31 Oct 2019 12:17:41 +0100 (CET)
Date:   Thu, 31 Oct 2019 12:17:41 +0100 (CET)
From:   =?UTF-8?Q?Kadlecsik_J=C3=B3zsef?= <kadlec@blackhole.kfki.hu>
To:     Stefano Brivio <sbrivio@redhat.com>
cc:     Jozsef Kadlecsik <kadlec@netfilter.org>,
        Chen Yi <yiche@redhat.com>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] ipset: Copy the right MAC address in hash:ip,mac IPv6
 sets
In-Reply-To: <48b62bbfab1983504cde5521c35e5a6e712997ae.1570727741.git.sbrivio@redhat.com>
Message-ID: <alpine.DEB.2.20.1910311216550.30748@blackhole.kfki.hu>
References: <48b62bbfab1983504cde5521c35e5a6e712997ae.1570727741.git.sbrivio@redhat.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Brivio,

On Thu, 10 Oct 2019, Stefano Brivio wrote:

> Same as commit 1b4a75108d5b ("netfilter: ipset: Copy the right MAC
> address in bitmap:ip,mac and hash:ip,mac sets"), another copy and paste
> went wrong in commit 8cc4ccf58379 ("netfilter: ipset: Allow matching on
> destination MAC address for mac and ipmac sets").

Thanks, patch is applied in the ipset git tree.

Best regards,
Jozsef
-
E-mail  : kadlec@blackhole.kfki.hu, kadlecsik.jozsef@wigner.mta.hu
PGP key : http://www.kfki.hu/~kadlec/pgp_public_key.txt
Address : Wigner Research Centre for Physics
          H-1525 Budapest 114, POB. 49, Hungary
