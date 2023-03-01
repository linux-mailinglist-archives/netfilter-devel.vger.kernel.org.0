Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465CB6A76C9
	for <lists+netfilter-devel@lfdr.de>; Wed,  1 Mar 2023 23:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjCAW2k (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 1 Mar 2023 17:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjCAW2k (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 1 Mar 2023 17:28:40 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 850C72333A
        for <netfilter-devel@vger.kernel.org>; Wed,  1 Mar 2023 14:28:39 -0800 (PST)
Date:   Wed, 1 Mar 2023 23:28:36 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Jozsef Kadlecsik <kadlec@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [ipset PATCH 0/2] Two minor code fixes
Message-ID: <Y//RlHWq86REFVu6@salvia>
References: <20230222170241.26208-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230222170241.26208-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Feb 22, 2023 at 06:02:39PM +0100, Phil Sutter wrote:
> These were identified by Coverity tool, no problems in practice. Still
> worth fixing to reduce noise in code checkers.

LGTM.

Did you run ipset xlate tests? These should not break those but just
in case.
