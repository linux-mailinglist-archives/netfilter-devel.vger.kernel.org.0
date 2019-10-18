Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAB5BDC30D
	for <lists+netfilter-devel@lfdr.de>; Fri, 18 Oct 2019 12:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbfJRKv0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 18 Oct 2019 06:51:26 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:34344 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725906AbfJRKvZ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 18 Oct 2019 06:51:25 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1iLPqp-0002g3-LZ; Fri, 18 Oct 2019 12:51:19 +0200
Date:   Fri, 18 Oct 2019 12:51:19 +0200
From:   Florian Westphal <fw@strlen.de>
To:     wenxu <wenxu@ucloud.cn>
Cc:     Florian Westphal <fw@strlen.de>, pablo@netfilter.org,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next] netfilter: nf_tables: add vlan support
Message-ID: <20191018105119.GZ25052@breakpoint.cc>
References: <1571392968-1263-1-git-send-email-wenxu@ucloud.cn>
 <20191018102402.GY25052@breakpoint.cc>
 <e7714199-ac8e-af7b-dc86-15f3aa19d3b2@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7714199-ac8e-af7b-dc86-15f3aa19d3b2@ucloud.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

wenxu <wenxu@ucloud.cn> wrote:
> > If you plan to extend this in the future then I'm fine with keeping it
> > as a module.
> It can add vlan tci / proto "get" expr and It also can support offload things in the future.

Ok, lets keep it as a module then.
