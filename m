Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA9431FC64
	for <lists+netfilter-devel@lfdr.de>; Fri, 19 Feb 2021 16:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhBSPrt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 19 Feb 2021 10:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhBSPrn (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 19 Feb 2021 10:47:43 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58B9C061756
        for <netfilter-devel@vger.kernel.org>; Fri, 19 Feb 2021 07:47:01 -0800 (PST)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1lD7ze-0007Nd-4G; Fri, 19 Feb 2021 16:46:58 +0100
Date:   Fri, 19 Feb 2021 16:46:58 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Eric Garver <eric@garver.life>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] json: init parser state for every new buffer/file
Message-ID: <20210219154658.GE22016@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>, Eric Garver <eric@garver.life>,
        netfilter-devel@vger.kernel.org
References: <20210219151126.3544581-1-eric@garver.life>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219151126.3544581-1-eric@garver.life>
Sender:  <n0-1@orbyte.nwl.cc>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Feb 19, 2021 at 10:11:26AM -0500, Eric Garver wrote:
> Otherwise invalid error states cause subsequent json parsing to fail
> when it should not.
> 
> Signed-off-by: Eric Garver <eric@garver.life>

Applied, thanks!
