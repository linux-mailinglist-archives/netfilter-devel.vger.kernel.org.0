Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3044F7AB87
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Jul 2019 16:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731013AbfG3O44 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 30 Jul 2019 10:56:56 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:43022 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727129AbfG3O44 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:56:56 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hsTYc-0004d1-WD; Tue, 30 Jul 2019 16:56:55 +0200
Date:   Tue, 30 Jul 2019 16:56:54 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org,
        bmastbergen@untangle.com
Subject: Re: [PATCH nft,RFC,PoC 2/2] src: restore typeof datatype when
 listing set definition
Message-ID: <20190730145654.q5ufyf75xrnfsh73@breakpoint.cc>
References: <20190730141620.2129-1-pablo@netfilter.org>
 <20190730141620.2129-3-pablo@netfilter.org>
 <20190730144141.k3dn37nlychhjk46@breakpoint.cc>
 <20190730144809.trhyxhhhxegoe47s@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730144809.trhyxhhhxegoe47s@salvia>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> Just make sure there's sufficient context around to rebuild the
> expression. Think of more complex fields that require bitmask
> operations.

Indeed, I had forgotten about those.
I agree that this should work as well.
