Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488DC1C6C68
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 May 2020 11:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgEFJH2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 6 May 2020 05:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728474AbgEFJH2 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 6 May 2020 05:07:28 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC733C061A0F
        for <netfilter-devel@vger.kernel.org>; Wed,  6 May 2020 02:07:27 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id E9DD35872FA74; Wed,  6 May 2020 11:07:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id E894D60C40095;
        Wed,  6 May 2020 11:07:23 +0200 (CEST)
Date:   Wed, 6 May 2020 11:07:23 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Huang Qijun <dknightjun@gmail.com>
cc:     pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
        davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] netfilter: fix make target xt_TCPMSS.o error.
In-Reply-To: <20200506065021.2881-1-dknightjun@gmail.com>
Message-ID: <nycvar.YFH.7.76.2005061106420.3951@n3.vanv.qr>
References: <20200506065021.2881-1-dknightjun@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wednesday 2020-05-06 08:50, Huang Qijun wrote:

>When compiling netfilter, there will be an error
>"No rule to make target 'net/netfilter/xt_TCPMSS.o'",
>because the xt_TCPMSS.c in the makefile is uppercase,
>and the file name of the source file (xt_tcpmss.c) is lowercase.

>-obj-$(CONFIG_NETFILTER_XT_TARGET_TCPMSS) += xt_TCPMSS.o
>+obj-$(CONFIG_NETFILTER_XT_TARGET_TCPMSS) += xt_tcpmss.o

Uhm, no:

11:07 a4:../net/netfilter » ls -l xt_*[Mm][Ss]*.c
-rw-r--r-- 1 jengelh users 8948 Feb 27 09:30 xt_TCPMSS.c
-rw-r--r-- 1 jengelh users 2459 Feb 27 09:30 xt_tcpmss.c
