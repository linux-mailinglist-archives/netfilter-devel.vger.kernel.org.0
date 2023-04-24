Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFD86DBC6F
	for <lists+netfilter-devel@lfdr.de>; Sat,  8 Apr 2023 20:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjDHSXY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 8 Apr 2023 14:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDHSXX (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 8 Apr 2023 14:23:23 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8B7B72A2
        for <netfilter-devel@vger.kernel.org>; Sat,  8 Apr 2023 11:23:22 -0700 (PDT)
Date:   Sat, 8 Apr 2023 20:23:20 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Dave Pifke <dave@pifke.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] src: try SO_SNDBUF before SO_SNDBUFFORCE
Message-ID: <ZDGxGJL7+5+CYu4H@calendula>
References: <87wn2n8ghs.fsf@stabbing.victim.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wn2n8ghs.fsf@stabbing.victim.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Apr 07, 2023 at 04:21:57PM -0600, Dave Pifke wrote:
> Prior to this patch, nft inside a systemd-nspawn container was failing
> to install my ruleset (which includes a large-ish map), with the error
> 
> netlink: Error: Could not process rule: Message too long
> 
> strace reveals:
> 
> setsockopt(3, SOL_SOCKET, SO_SNDBUFFORCE, [524288], 4) = -1 EPERM (Operation not permitted)
> 
> This is despite the nspawn process supposedly having CAP_NET_ADMIN,
> and despite /proc/sys/net/core/wmem_max (in the main host namespace)
> being set larger than the requested size:
> 
> net.core.wmem_max = 16777216
> 
> A web search reveals at least one other user having the same issue:
> 
> https://old.reddit.com/r/Proxmox/comments/scnoav/lxc_container_debian_11_nftables_geoblocking/
> 
> After this patch, nft succeeds.

Patch LGTM.

May I add your Signed-off-by: tag to this patch before applying it?

Thanks.
