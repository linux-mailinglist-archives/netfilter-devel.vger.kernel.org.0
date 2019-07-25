Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 652DE74B5E
	for <lists+netfilter-devel@lfdr.de>; Thu, 25 Jul 2019 12:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389964AbfGYKSv (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 25 Jul 2019 06:18:51 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:43832 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388090AbfGYKSv (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 25 Jul 2019 06:18:51 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hqapl-0001MW-Bm; Thu, 25 Jul 2019 12:18:49 +0200
Date:   Thu, 25 Jul 2019 12:18:49 +0200
From:   Florian Westphal <fw@strlen.de>
To:     wenxu@ucloud.cn
Cc:     pablo@netfilter.org, fw@strlen.de, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next v2 0/5] sipport nft_tunnel offload
Message-ID: <20190725101849.kz2eyuscvuhili2r@breakpoint.cc>
References: <1564047969-26514-1-git-send-email-wenxu@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564047969-26514-1-git-send-email-wenxu@ucloud.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

wenxu@ucloud.cn <wenxu@ucloud.cn> wrote:
> From: wenxu <wenxu@ucloud.cn>
> 
> This series support tunnel meta match offload and
> tunnel_obj ation offload. This series depends on
> http://patchwork.ozlabs.org/project/netfilter-devel/list/?series=120961

Can you provide a summary of changes since last iteration either
in the cover letter or the individual patches?

Otherwise its hard for me to follow what is being changed.
