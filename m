Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A33C30A4E
	for <lists+netfilter-devel@lfdr.de>; Fri, 31 May 2019 10:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfEaIbN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 31 May 2019 04:31:13 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:40960 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfEaIbN (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 31 May 2019 04:31:13 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id A0D8B25AE77;
        Fri, 31 May 2019 18:31:11 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 9109F940461; Fri, 31 May 2019 10:31:09 +0200 (CEST)
Date:   Fri, 31 May 2019 10:31:09 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next 2/8] netfilter: ipvs: prefer skb_ensure_writable
Message-ID: <20190531083109.rqxgzrmhur54lvjd@verge.net.au>
References: <20190523134412.3295-1-fw@strlen.de>
 <20190523134412.3295-3-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523134412.3295-3-fw@strlen.de>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, May 23, 2019 at 03:44:06PM +0200, Florian Westphal wrote:
> It does the same thing, use it instead so we can remove skb_make_writable.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>

Acked-by: Simon Horman <horms@verge.net.au>
