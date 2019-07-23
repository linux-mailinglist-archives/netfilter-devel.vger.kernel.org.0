Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE3772289
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jul 2019 00:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730916AbfGWWoP (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 23 Jul 2019 18:44:15 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:33384 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729328AbfGWWoP (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 23 Jul 2019 18:44:15 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hq3W0-0005MY-6g; Wed, 24 Jul 2019 00:44:12 +0200
Date:   Wed, 24 Jul 2019 00:44:12 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft 3/3] src: evaluate: return immediately if no op was
 requested
Message-ID: <20190723224412.xnkzyqf2vp6dyztu@breakpoint.cc>
References: <20190721001406.23785-1-fw@strlen.de>
 <20190721001406.23785-4-fw@strlen.de>
 <20190723191832.yz53ewe7smtujsmf@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723191832.yz53ewe7smtujsmf@salvia>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> This one should fix this bugzilla:
> 
> http://git.netfilter.org/nftables/commit/?id=3ab02db5f836ae0cf9fe7fba616d7eb52139d537

much better fix, thanks Pablo!
