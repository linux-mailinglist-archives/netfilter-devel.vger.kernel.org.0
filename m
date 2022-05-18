Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0FE52BD13
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 May 2022 16:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238228AbiERN4u (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 18 May 2022 09:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238594AbiERN4Z (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 18 May 2022 09:56:25 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3A54B29
        for <netfilter-devel@vger.kernel.org>; Wed, 18 May 2022 06:56:24 -0700 (PDT)
Date:   Wed, 18 May 2022 15:56:21 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Ritaro Takenaka <ritarot634@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v3] netfilter: nf_flowtable: move dst_check to packet path
Message-ID: <YoT7BaLzml2Y8L+L@salvia>
References: <20220517100041.966527-1-ritarot634@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220517100041.966527-1-ritarot634@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, May 17, 2022 at 07:00:43PM +0900, Ritaro Takenaka wrote:
> Fixes sporadic IPv6 packet loss when flow offloading is enabled.
> 
> IPv6 route GC and flowtable GC are not synchronized.
> When dst_cache becomes stale and a packet passes through the flow before
> the flowtable GC teardowns it, the packet can be dropped.
> So, it is necessary to check dst every time in packet path.

Applied to nf.git, thanks
