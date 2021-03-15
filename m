Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A47233C4C6
	for <lists+netfilter-devel@lfdr.de>; Mon, 15 Mar 2021 18:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhCORtH (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 15 Mar 2021 13:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbhCORsi (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 15 Mar 2021 13:48:38 -0400
Received: from mail.netfilter.org (mail.netfilter.org [IPv6:2001:4b98:dc0:41:216:3eff:fe8c:2bda])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8E6CC061764
        for <netfilter-devel@vger.kernel.org>; Mon, 15 Mar 2021 10:46:05 -0700 (PDT)
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id DEB276353A;
        Mon, 15 Mar 2021 18:43:46 +0100 (CET)
Date:   Mon, 15 Mar 2021 18:43:45 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: ctnetlink: fix dump of the expect mask
 attribute
Message-ID: <20210315174345.GA25442@salvia>
References: <20210315103109.12004-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210315103109.12004-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Mar 15, 2021 at 11:31:09AM +0100, Florian Westphal wrote:
> Before this change, the mask is never included in the netlink message, so
> "conntrack -E expect" always prints 0.0.0.0.
> 
> In older kernels the l3num callback struct was passed as argument, based
> on tuple->src.l3num. After the l3num indirection got removed, the call
> chain is based on m.src.l3num, but this value is 0xffff.
> 
> Init l3num to the correct value.

Applied, thanks.
