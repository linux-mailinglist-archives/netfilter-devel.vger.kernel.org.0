Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57E79DA6DC
	for <lists+netfilter-devel@lfdr.de>; Thu, 17 Oct 2019 10:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437972AbfJQIA7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 17 Oct 2019 04:00:59 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:55602 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392718AbfJQIA7 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 17 Oct 2019 04:00:59 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1iL0iQ-0002Dk-9F; Thu, 17 Oct 2019 10:00:58 +0200
Date:   Thu, 17 Oct 2019 10:00:58 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH 3/4] tests/monitor: Fix for changed ct timeout format
Message-ID: <20191017080058.GU25052@breakpoint.cc>
References: <20191016230322.24432-1-phil@nwl.cc>
 <20191016230322.24432-4-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016230322.24432-4-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> Commit a9b0c385a1d5e ("rule: print space between policy and timeout")
> changed spacing in ct timeout objects but missed to adjust related test
> case.

Acked-by: Florian Westphal <fw@strlen.de>
