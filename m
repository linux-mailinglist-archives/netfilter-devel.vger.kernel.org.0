Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D91069B290
	for <lists+netfilter-devel@lfdr.de>; Fri, 17 Feb 2023 19:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjBQStZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 17 Feb 2023 13:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBQStZ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 17 Feb 2023 13:49:25 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FEA15553
        for <netfilter-devel@vger.kernel.org>; Fri, 17 Feb 2023 10:49:24 -0800 (PST)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1pT5nP-0005eR-48
        for netfilter-devel@vger.kernel.org; Fri, 17 Feb 2023 19:49:23 +0100
Date:   Fri, 17 Feb 2023 19:49:23 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH 1/6] extensions: libebt_redirect: Fix target
 translation
Message-ID: <Y+/MMwi8ACC1yTRa@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        netfilter-devel@vger.kernel.org
References: <20230217161715.26120-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217161715.26120-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Feb 17, 2023 at 05:17:10PM +0100, Phil Sutter wrote:
> While EBT_ACCEPT is the default verdict for ebtables targets, omitting
> it from translation implicitly converts it into 'continue'. Omit the
> non-default EBT_CONTINUE instead.
> 
> Fixes: 24ce7465056ae ("ebtables-compat: add redirect match extension")
> Signed-off-by: Phil Sutter <phil@nwl.cc>

And this series also applied. ;)
