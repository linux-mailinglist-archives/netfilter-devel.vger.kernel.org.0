Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C342868195
	for <lists+netfilter-devel@lfdr.de>; Mon, 15 Jul 2019 01:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbfGNX2K convert rfc822-to-8bit (ORCPT
        <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 14 Jul 2019 19:28:10 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:46926 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728803AbfGNX2K (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 14 Jul 2019 19:28:10 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hmnua-00018j-Ua; Mon, 15 Jul 2019 01:28:09 +0200
Date:   Mon, 15 Jul 2019 01:28:08 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Ander Juaristi <a@juaristi.eus>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v2] netfilter: nft_meta: support for time matching
Message-ID: <20190714232808.rb3wc44ij7ixz376@breakpoint.cc>
References: <20190707205707.6728-1-a@juaristi.eus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190707205707.6728-1-a@juaristi.eus>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Ander Juaristi <a@juaristi.eus> wrote:
> This patch introduces meta matches in the kernel for time (a UNIX timestamp),
> day (a day of week, represented as an integer between 0-6), and
> hour (an hour in the current day, or: number of seconds since midnight).
> 
> All values are taken as unsigned 64-bit integers.
> 
> The 'time' keyword is internally converted to nanoseconds by nft in
> userspace, and hence the timestamp is taken in nanoseconds as well.

I think this is conceptually fine, thanks Ander.

Can you run this throuch scripts/checkpatch.pl and fix up the style
nits?

> +	case NFT_META_TIME_HOUR:
> +		len = sizeof(u64);

As in my other comment, I think this can be u32.
