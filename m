Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3BA8287A7F
	for <lists+netfilter-devel@lfdr.de>; Thu,  8 Oct 2020 19:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbgJHRCr (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 8 Oct 2020 13:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbgJHRCr (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 8 Oct 2020 13:02:47 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7A5C061755
        for <netfilter-devel@vger.kernel.org>; Thu,  8 Oct 2020 10:02:47 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1kQZJV-0007fP-CV; Thu, 08 Oct 2020 19:02:45 +0200
Date:   Thu, 8 Oct 2020 19:02:45 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Gopal Yadav <gopunop@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v2] Solves Bug 1462 - `nft -j list set` does not show
 counters
Message-ID: <20201008170245.GC13016@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Gopal Yadav <gopunop@gmail.com>, netfilter-devel@vger.kernel.org
References: <20201007140337.21218-1-gopunop@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007140337.21218-1-gopunop@gmail.com>
Sender:  <n0-1@orbyte.nwl.cc>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Oct 07, 2020 at 07:33:37PM +0530, Gopal Yadav wrote:
> Solves Bug 1462 - `nft -j list set` does not show counters
> 
> Signed-off-by: Gopal Yadav <gopunop@gmail.com>

Added a comment about potential clashes (json_object_update_missing()
hides those) and replaced the duplicate subject line by a commit
message, then applied the result.

Thanks, Phil
