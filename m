Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93B4C9CBC0
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Aug 2019 10:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbfHZIjC (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 26 Aug 2019 04:39:02 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:40525 "EHLO
        ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729737AbfHZIjC (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 26 Aug 2019 04:39:02 -0400
Received: from [31.4.214.68] (helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <pablo@gnumonks.org>)
        id 1i2AWb-0000CS-WA; Mon, 26 Aug 2019 10:39:00 +0200
Date:   Mon, 26 Aug 2019 10:38:51 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     wenxu@ucloud.cn
Cc:     fw@strlen.de, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next v2] netfilter: nf_table_offload: Fix the
 incorrect rcu usage in nft_indr_block_get_and_ing_cmd
Message-ID: <20190826082350.srv23fnbipovzkvu@salvia>
References: <1566220952-27225-1-git-send-email-wenxu@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566220952-27225-1-git-send-email-wenxu@ucloud.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Score: -2.6 (--)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Aug 19, 2019 at 09:22:32PM +0800, wenxu@ucloud.cn wrote:
> From: wenxu <wenxu@ucloud.cn>
> 
> The flow_block_ing_cmd() needs to call blocking functions while iterating
> block_ing_cb_list, nft_indr_block_get_and_ing_cmd is in the cb_list,
> So it is the incorrect rcu case. To fix it just traverse the list under
> the commit mutex.

The flow_indr_block_call() is called from a path that already holds
this lock.
