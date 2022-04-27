Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC245120D4
	for <lists+netfilter-devel@lfdr.de>; Wed, 27 Apr 2022 20:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239101AbiD0POI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 27 Apr 2022 11:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239548AbiD0POH (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:14:07 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76A1127CE1
        for <netfilter-devel@vger.kernel.org>; Wed, 27 Apr 2022 08:10:55 -0700 (PDT)
Date:   Wed, 27 Apr 2022 17:10:50 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Ritaro Takenaka <ritarot634@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] nf_flowtable: ensure dst.dev is not blackhole
Message-ID: <Ymlc+vl4TUE57Q3+@salvia>
References: <20220425080835.5765-1-ritarot634@gmail.com>
 <YmfVpecE2UuiP6p8@salvia>
 <04e2c223-7936-481d-0032-0a55a21dca7a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <04e2c223-7936-481d-0032-0a55a21dca7a@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Apr 26, 2022 at 09:28:13PM +0900, Ritaro Takenaka wrote:
> Thanks for your reply.
> 
> > In 5.4, this check is only enabled for xfrm.
> Packet loss occurs with xmit (xfrm is not confirmed).
> I also experienced packet loss with 5.10, which runs dst_check periodically.
> Route GC and flowtable GC are not synchronized, so it is
> necessary to check each packet.
> 
> > dst_check() should deal with this.
> When dst_check is used, the performance degradation is not negligible.
> From 900 Mbps to 700 Mbps with QCA9563 simple firewall.

You mention 5.10 above.

Starting 5.12, dst_check() uses INDIRECT_CALL_INET.

Is dst_check() still slow with >= 5.12?

Asking this because my understanding (at this stage) is that this
check for blackhole_netdev is a faster way to check for stale cached
routes.
