Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C5F28E0BD
	for <lists+netfilter-devel@lfdr.de>; Wed, 14 Oct 2020 14:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgJNMrQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 14 Oct 2020 08:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730883AbgJNMrN (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 14 Oct 2020 08:47:13 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FD5C061755
        for <netfilter-devel@vger.kernel.org>; Wed, 14 Oct 2020 05:47:13 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1kSgBT-0001td-86; Wed, 14 Oct 2020 14:47:11 +0200
Date:   Wed, 14 Oct 2020 14:47:11 +0200
From:   Florian Westphal <fw@strlen.de>
To:     timothee.cocault@orange.com
Cc:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH] Fixes dropping of small packets in bridge nat
Message-ID: <20201014124711.GC16895@breakpoint.cc>
References: <585B71F7B267D04784B84104A88F7DEE0DB503A6@OPEXCAUBM34.corporate.adroot.infra.ftgroup>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <585B71F7B267D04784B84104A88F7DEE0DB503A6@OPEXCAUBM34.corporate.adroot.infra.ftgroup>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

timothee.cocault@orange.com <timothee.cocault@orange.com> wrote:
> Fixes an error causing small packets to get dropped. skb_ensure_writable
> expects the second parameter to be a length in the ethernet payload. 
> If we want to write the ethernet header (src, dst), we should pass 0.
> Otherwise, packets with small payloads (< ETH_ALEN) will get dropped.

Reviewed-by: Florian Westphal <fw@strlen.de>
