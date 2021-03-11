Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3457337914
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Mar 2021 17:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbhCKQSw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 11 Mar 2021 11:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbhCKQSe (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:18:34 -0500
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F05C061574
        for <netfilter-devel@vger.kernel.org>; Thu, 11 Mar 2021 08:18:34 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 25121)
        id EA6BE59E09DB4; Thu, 11 Mar 2021 17:18:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id E903260D3BCAA;
        Thu, 11 Mar 2021 17:18:31 +0100 (CET)
Date:   Thu, 11 Mar 2021 17:18:31 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     =?UTF-8?Q?Milan_P=2E_Stani=C4=87?= <mps@arvanta.net>
cc:     Netfilter Developer Mailing List 
        <netfilter-devel@vger.kernel.org>,
        Paolo Pisati <p.pisati@gmail.com>
Subject: Re: xtables-addons-3.17 fail build on armv7 with musl libc
In-Reply-To: <YEaQ2wXhLxG69EQg@arya.arvanta.net>
Message-ID: <813166p2-2s15-op14-8r17-64oo79q9n@vanv.qr>
References: <YEaQ2wXhLxG69EQg@arya.arvanta.net>
User-Agent: Alpine 2.24 (LSU 510 2020-10-10)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Monday 2021-03-08 22:02, Milan P. Stanić wrote:

>I'm trying to fix build of xtables-addons-3.17 on Alpine Linux which is
>based on musl libc. Build pass on our x86, x86_64, aarch64, ppc64le and
>s390x arches but fails on armv7. Here is excerpt from build log.
>
>   33 | static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
>      |                                   ~~~~~~~~~~^

I have addresses the issue in v3.18 now. No new warnings have shown to me with
regards to time_after.
