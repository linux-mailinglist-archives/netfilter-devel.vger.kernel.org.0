Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FAA586791
	for <lists+netfilter-devel@lfdr.de>; Mon,  1 Aug 2022 12:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiHAKiF (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 1 Aug 2022 06:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiHAKiE (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 1 Aug 2022 06:38:04 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1B3F371A6
        for <netfilter-devel@vger.kernel.org>; Mon,  1 Aug 2022 03:38:03 -0700 (PDT)
Date:   Mon, 1 Aug 2022 12:37:59 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     wenxu@chinatelecom.cn
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next v2 2/3] nf_flow_table_offload: offload the PPPoE
 encap in the flowtable
Message-ID: <YuetB9cZNovLFldA@salvia>
References: <1653548252-2602-1-git-send-email-wenxu@chinatelecom.cn>
 <1653548252-2602-2-git-send-email-wenxu@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1653548252-2602-2-git-send-email-wenxu@chinatelecom.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, May 26, 2022 at 02:57:31AM -0400, wenxu@chinatelecom.cn wrote:
> From: wenxu <wenxu@chinatelecom.cn>
> 
> This patch put the pppoe process in the FLOW_OFFLOAD_XMIT_DIRECT
> mode. Xmit the packet with PPPoE can offload to the underlay device
> directly.
> 
> It can support all kinds of VLAN dev path:
> pppoe-->eth
> pppoe-->br0.100-->br0(vlan filter enable)-->eth
> pppoe-->eth.100-->eth
> 
> The packet xmit and recv offload to the 'eth' in both original and
> reply direction.

This should provide a significant speed up in packet forwarding, since
packets are not passed up to userspace anymore via ppp driver.

BTW, what userspace ppp software are you using to test this?
