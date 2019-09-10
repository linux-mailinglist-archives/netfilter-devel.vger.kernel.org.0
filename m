Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6624CAE956
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Sep 2019 13:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731137AbfIJLoN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 10 Sep 2019 07:44:13 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:42944 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728639AbfIJLoN (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 10 Sep 2019 07:44:13 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1i7eZA-0005zg-Aa; Tue, 10 Sep 2019 13:44:12 +0200
Date:   Tue, 10 Sep 2019 13:44:12 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org,
        Eric Garver <eric@garver.life>
Subject: Re: [PATCH nft] src: mnl: fix --echo buffer size -- again
Message-ID: <20190910114412.GA22704@breakpoint.cc>
References: <20190909221918.28473-1-fw@strlen.de>
 <20190910085056.bfbgsgvhraatmsuc@salvia>
 <20190910105242.GC2066@breakpoint.cc>
 <20190910112254.isfbdqjfg6aokcm7@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910112254.isfbdqjfg6aokcm7@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> I'd still like to keep setting the receive buffer for the non-echo
> case, a ruleset with lots of acknowledments (lots of errors) might hit
> ENOBUFS, I remember that was reproducible.
> 
> Probably this? it's based on your patch.

LGTM, feel free to apply this.
