Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174BF348EC2
	for <lists+netfilter-devel@lfdr.de>; Thu, 25 Mar 2021 12:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhCYLOh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 25 Mar 2021 07:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhCYLOX (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 25 Mar 2021 07:14:23 -0400
Received: from mail.netfilter.org (mail.netfilter.org [IPv6:2001:4b98:dc0:41:216:3eff:fe8c:2bda])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 799BCC06174A
        for <netfilter-devel@vger.kernel.org>; Thu, 25 Mar 2021 04:14:23 -0700 (PDT)
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 1C41B630BB;
        Thu, 25 Mar 2021 12:14:06 +0100 (CET)
Date:   Thu, 25 Mar 2021 12:14:12 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] nftables: add flags offload to flowtable
Message-ID: <20210325111412.GA24785@salvia>
References: <20210321164916.62556-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210321164916.62556-1-linux@fw-web.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Mar 21, 2021 at 05:49:16PM +0100, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> allow flags (currently only offload) in flowtables like it is stated
> here: https://lwn.net/Articles/804384/
> 
> tested on mt7622/Bananapi-R64
> 
> table ip filter {
> 	flowtable f {
> 		hook ingress priority filter + 1
> 		devices = { lan3, lan0, wan }
> 		flags offload;
> 	}
> 
> 	chain forward {
> 		type filter hook forward priority filter; policy accept;
> 		ip protocol { tcp, udp } flow add @f
> 	}
> }
> 
> table ip nat {
> 	chain post {
> 		type nat hook postrouting priority filter; policy accept;
> 		oifname "wan" masquerade
> 	}
> }

Applied, thanks.
