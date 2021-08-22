Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84283F3F0C
	for <lists+netfilter-devel@lfdr.de>; Sun, 22 Aug 2021 13:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbhHVLU3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 22 Aug 2021 07:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbhHVLU2 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 22 Aug 2021 07:20:28 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE526C061575
        for <netfilter-devel@vger.kernel.org>; Sun, 22 Aug 2021 04:19:47 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 78B155872F6C4; Sun, 22 Aug 2021 13:19:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 77F1560C2C522;
        Sun, 22 Aug 2021 13:19:46 +0200 (CEST)
Date:   Sun, 22 Aug 2021 13:19:46 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     =?UTF-8?Q?Grzegorz_Kuczy=C5=84ski?= <grzegorz.kuczynski@interia.eu>
cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] xtables-addons 3.18 condition - Improved network namespace
 support
In-Reply-To: <a2e36a8e-939f-453d-8a0d-d6ef61bbf280@interia.eu>
Message-ID: <7q54s2p2-7o57-3rq-9012-np5o3sr1s416@vanv.qr>
References: <a2e36a8e-939f-453d-8a0d-d6ef61bbf280@interia.eu>
User-Agent: Alpine 2.24 (LSU 510 2020-10-10)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Friday 2021-08-20 20:24, Grzegorz Kuczyński wrote:

>Hello
>A few years ago I add network namespace to extension condition.
>I review this changes again and make changes again.
>This is better version.

It does not apply. Your mail software mangled the patch.

I would also wish for a more precise description what causes
these lines to need removal.

>-       if (cnet->after_clear)
>-               return;

>-       if (--var->refcount == 0) {
>+       if (--var->refcount == 0 &&
>!list_empty_careful(&cnet->conditions_list)) {
