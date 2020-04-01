Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 836BA19AF4D
	for <lists+netfilter-devel@lfdr.de>; Wed,  1 Apr 2020 18:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbgDAQFZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 1 Apr 2020 12:05:25 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:39846 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730720AbgDAQFZ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:05:25 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1jJfro-0004ZH-51; Wed, 01 Apr 2020 18:05:24 +0200
Date:   Wed, 1 Apr 2020 18:05:24 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] tests: shell: add typeof with concatenations
Message-ID: <20200401160524.GI23604@breakpoint.cc>
References: <20200401155157.195806-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401155157.195806-1-pablo@netfilter.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> Add a test to cover typeof with concatenations.
> 
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
>  tests/shell/testcases/sets/0045typeof_sets_0           | 14 ++++++++++++++
>  tests/shell/testcases/sets/dumps/0045typeof_sets_0.nft |  7 +++++++
>  2 files changed, 21 insertions(+)
>  create mode 100755 tests/shell/testcases/sets/0045typeof_sets_0
>  create mode 100644 tests/shell/testcases/sets/dumps/0045typeof_sets_0.nft

Thanks, but I already pushed a test case for this, sorry :/
