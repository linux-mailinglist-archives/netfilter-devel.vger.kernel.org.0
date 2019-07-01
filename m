Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18A8031644
	for <lists+netfilter-devel@lfdr.de>; Fri, 31 May 2019 22:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfEaUot (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 31 May 2019 16:44:49 -0400
Received: from mx1.riseup.net ([198.252.153.129]:52430 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbfEaUos (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 31 May 2019 16:44:48 -0400
Received: from capuchin.riseup.net (capuchin-pn.riseup.net [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id 32C8E1A0673;
        Fri, 31 May 2019 13:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1559335488; bh=O2O2dnhg5hI5TR8JZK+JH3gVO861CnJ1jDo1ihOPsmY=;
        h=To:Cc:From:Subject:Date:From;
        b=PmBonw44T/pOzdFDv046eJwJeGemS/66mqbZcLImcbb4JKJbdwbhJ55LsoAKpWtFi
         64EpRIa6G0cU969nmhUDUMywQZbhc7g7ROq2bvuB93CrlolWLRVetBrS92fONd1XnB
         r1J9LHypyWhWedcQJjAHUmZy3NCLuodOl0WgzfTw=
X-Riseup-User-ID: 838FC9B9CEC636ACAFBA82F04C0611902816D18913C3A6F2B8C196498A2F1119
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 2C042120CC6;
        Fri, 31 May 2019 13:44:46 -0700 (PDT)
To:     netfilter-devel@vger.kernel.org
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>
From:   Fernando Fernandez Mancera <ffmancera@riseup.net>
Subject: Kernel compilation error
Openpgp: preference=signencrypt
Message-ID: <a4fc9076-f051-9dc6-90d5-f62d70d74068@riseup.net>
Date:   Fri, 31 May 2019 22:44:58 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

I am getting the following error when compiling the kernel after pull
the last changes from nf-next.git.

>   CC      security/apparmor/lsm.o
>   CC      kernel/trace/trace_stack.o
> In file included from security/apparmor/lsm.c:27:
> ./include/linux/netfilter_ipv6.h: In function ‘nf_ipv6_br_defrag’:
> ./include/linux/netfilter_ipv6.h:113:9: error: implicit declaration of function ‘nf_ct_frag6_gather’; did you mean ‘nf_ct_attach’? [-Werror=implicit-function-declaration]
>   return nf_ct_frag6_gather(net, skb, user);
>          ^~~~~~~~~~~~~~~~~~
>          nf_ct_attach
>   CC [M]  arch/x86/kvm/mmu.o

I have been taking a loook into .config for any missing module but I
didn't find anything wrong. Is this a known issue? Thanks!

Regards,
Fernando.
