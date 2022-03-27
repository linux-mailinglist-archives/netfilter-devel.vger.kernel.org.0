Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D435F4E8A39
	for <lists+netfilter-devel@lfdr.de>; Sun, 27 Mar 2022 23:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbiC0Vd2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 27 Mar 2022 17:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiC0Vd2 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 27 Mar 2022 17:33:28 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FEF0201AB
        for <netfilter-devel@vger.kernel.org>; Sun, 27 Mar 2022 14:31:49 -0700 (PDT)
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id B003A6301D;
        Sun, 27 Mar 2022 23:28:42 +0200 (CEST)
Date:   Sun, 27 Mar 2022 23:31:45 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: Support for loading firewall rules with cgroup(v2) expressions
 early
Message-ID: <YkDXwaPwYf8NgKT+@salvia>
References: <fabde324-383a-622c-7e69-32c9b2d06191@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fabde324-383a-622c-7e69-32c9b2d06191@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Sat, Mar 26, 2022 at 12:09:26PM +0200, Topi Miettinen wrote:
> Hi,
> 
> I'd like to use cgroupv2 expressions in firewall rules. But since the rules
> are loaded very early in the boot, the expressions are rejected since the
> target cgroups are not realized until much later.
> 
> Would it be possible to add new cgroupv2 expressions which defer the check
> until actual use? For example, 'cgroupv2name' (like iifname etc.) would
> check the cgroup path string at rule use time?
> 
> Another possibility would be to hook into cgroup directory creation logic in
> kernel so that when the cgroup is created, part of the path checks are
> performed or something else which would allow non-existent cgroups to be
> used. Then the NFT syntax would not need changing, but the expressions would
> "just work" even when loaded early.

Could you use inotify/dnotify/eventfd to track these updates from
userspace and update the nftables sets accordingly? AFAIK, this is
available to cgroupsv2.

> Indirection through sets ('socket cgroupv2 level @lvl @cgname drop') might
> work in some cases, but it would need support from cgroup manager like
> systemd which would manage the sets. This would also probably not be
> scalable to unprivileged users or containers.
> 
> This also applies to old cgroup (v1) expression but that's probably not
> worth improving anymore.
> 
> Related work on systemd side:
> https://github.com/systemd/systemd/issues/22527
> 
> -Topi
