Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED3B1FB5F9
	for <lists+netfilter-devel@lfdr.de>; Tue, 16 Jun 2020 17:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbgFPPV2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 16 Jun 2020 11:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728809AbgFPPV2 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:21:28 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E17C061573
        for <netfilter-devel@vger.kernel.org>; Tue, 16 Jun 2020 08:21:28 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 3B9BD58742E48; Tue, 16 Jun 2020 17:21:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 3AB6C60E4F92F;
        Tue, 16 Jun 2020 17:21:26 +0200 (CEST)
Date:   Tue, 16 Jun 2020 17:21:26 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Eugene Crosser <crosser@average.org>
cc:     netfilter-devel@vger.kernel.org
Subject: Re: ebtables: load-on-demand extensions
In-Reply-To: <76cd59a3-6403-9408-1b8c-af5f11d5fa85@average.org>
Message-ID: <nycvar.YFH.7.77.849.2006161717590.16107@n3.vanv.qr>
References: <76cd59a3-6403-9408-1b8c-af5f11d5fa85@average.org>
User-Agent: Alpine 2.22 (LSU 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On Tuesday 2020-06-16 16:48, Eugene Crosser wrote:
>
>2. Is it correct that "new generation" `nft` filtering infrastructure
>does not support dynamically loadable extensions at all? (We need a
>custom kernel module because we need access to the fields in the skb
>that are not exposed to `nft`, and we need a custom extension to
>configure the custom module.)

Why not make a patch to publicly expose the skb's data via nft_meta?
No more custom modules, no more userspace modifications, that would seem 
to be a win-win situation.
