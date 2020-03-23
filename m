Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 443C918F512
	for <lists+netfilter-devel@lfdr.de>; Mon, 23 Mar 2020 13:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbgCWMyN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 23 Mar 2020 08:54:13 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:46206 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727582AbgCWMyN (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 23 Mar 2020 08:54:13 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1jGMap-0000GB-RK; Mon, 23 Mar 2020 13:54:11 +0100
Date:   Mon, 23 Mar 2020 13:54:11 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] selftests: netfilter: add nfqueue test case
Message-ID: <20200323125411.GD3305@breakpoint.cc>
References: <20200323125200.2396-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323125200.2396-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Florian Westphal <fw@strlen.de> wrote:
> Add a test case to check nf queue infrastructure.
> Could be extended in the future to also cover serialization of
> conntrack, uid and secctx attributes in nfqueue.

Grrr, please disregard.  I commented out a few tests that should be
there. 

I will send a v2 later.
