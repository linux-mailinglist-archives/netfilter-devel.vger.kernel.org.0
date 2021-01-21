Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989BB2FEE51
	for <lists+netfilter-devel@lfdr.de>; Thu, 21 Jan 2021 16:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731770AbhAUPNm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 21 Jan 2021 10:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732656AbhAUPNO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 21 Jan 2021 10:13:14 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EE4C0613D6
        for <netfilter-devel@vger.kernel.org>; Thu, 21 Jan 2021 07:12:34 -0800 (PST)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1l2bdQ-0003uj-Jf; Thu, 21 Jan 2021 16:12:32 +0100
Date:   Thu, 21 Jan 2021 16:12:32 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 1/4] json: fix icmpv6.t test cases
Message-ID: <20210121151232.GT3158@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
References: <20210121135510.14941-1-fw@strlen.de>
 <20210121135510.14941-2-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121135510.14941-2-fw@strlen.de>
Sender:  <n0-1@orbyte.nwl.cc>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Jan 21, 2021 at 02:55:07PM +0100, Florian Westphal wrote:
> Signed-off-by: Florian Westphal <fw@strlen.de>

Acked-by: Phil Sutter <phil@nwl.cc>
