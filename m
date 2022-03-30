Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045774EB887
	for <lists+netfilter-devel@lfdr.de>; Wed, 30 Mar 2022 04:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241359AbiC3CzP (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 29 Mar 2022 22:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241774AbiC3CzO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 29 Mar 2022 22:55:14 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83B27B6C
        for <netfilter-devel@vger.kernel.org>; Tue, 29 Mar 2022 19:53:28 -0700 (PDT)
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id C8CDB63012;
        Wed, 30 Mar 2022 04:50:13 +0200 (CEST)
Date:   Wed, 30 Mar 2022 04:53:25 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: Support for loading firewall rules with cgroup(v2) expressions
 early
Message-ID: <YkPGJRUAuaLKrA0I@salvia>
References: <fabde324-383a-622c-7e69-32c9b2d06191@gmail.com>
 <YkDXwaPwYf8NgKT+@salvia>
 <418f6461-4504-4707-5ec2-61227af2ad27@gmail.com>
 <YkHOuprHwwuXjWrm@salvia>
 <5b850d67-92c1-9ece-99d2-390e8a5731b3@gmail.com>
 <YkOF0LyDSqKX6ERe@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YkOF0LyDSqKX6ERe@salvia>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Mar 30, 2022 at 12:25:25AM +0200, Pablo Neira Ayuso wrote:
> On Tue, Mar 29, 2022 at 09:20:25PM +0300, Topi Miettinen wrote:
[...]
> You could define a ruleset that describes the policy following the
> cgroupsv2 hierarchy. Something like this:
> 
>  table inet filter {
>         map dict_cgroup_level_1 {
>                 type cgroupsv2 : verdict;
>                 elements = { "system.slice" : jump system_slice }
>         }
> 
>         map dict_cgroup_level_2 {
>                 type cgroupsv2 : verdict;
>                 elements = { "system.slice/systemd-timesyncd.service" : jump systemd_timesyncd }
>         }
> 
>         chain systemd_timesyncd {
>                 # systemd-timesyncd policy
>         }
> 
>         chain system_slice {
>                 socket cgroupv2 level 2 vmap @dict_cgroup_level_2
>                 # policy for system.slice process
>         }
> 
>         chain input {
>                 type filter hook input priority filter; policy drop;

This example should use the output chain instead:

          chain output {
                  type filter hook output priority filter; policy drop;

From the input chain, the packet relies on early demux to have access
to the socket.

The idea would be to filter out outgoing traffic and rely on conntrack
for (established) input traffic.

>                 socket cgroupv2 level 1 vmap @dict_cgroup_level_1
>         }
>  }
