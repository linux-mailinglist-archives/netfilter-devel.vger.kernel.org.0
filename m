Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82EC667179
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Jan 2023 12:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbjALL7y (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 12 Jan 2023 06:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbjALL71 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:59:27 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECD53564C5;
        Thu, 12 Jan 2023 03:53:34 -0800 (PST)
Date:   Thu, 12 Jan 2023 12:53:31 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Martin Zaharinov <micron10@gmail.com>
Cc:     netfilter <netfilter@vger.kernel.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [nft] src: allow for updating devices on existing netdev chain -
 Test result
Message-ID: <Y7/0ux6h0jk7Fdk/@salvia>
References: <DD658C3B-2FB9-451E-893C-EE37ABDC678A@gmail.com>
 <72087908-1387-4D9F-A4D1-7DC5C276155E@gmail.com>
 <E87AFF49-E4A3-43B7-8799-C0A5E3591BCD@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E87AFF49-E4A3-43B7-8799-C0A5E3591BCD@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Jan 12, 2023 at 01:50:38PM +0200, Martin Zaharinov wrote:
> Hi Pablo 
> 
> Do you have time to check this ?

Busy here sorry.

Why don't you use batch mode to speed up registration rather than
triggering lots of forks, one after another?

for i in `seq 2 9999`; do echo "link add d$i type dummy" >> /tmp/batch; done     
for i in `seq 2 9999`; do echo "create chain netdev x int$i { type filter hook egress priority -500; policy accept; }" >> /tmp/ruleset.nft; done
for i in `seq 2 9999`; do echo "add chain netdev x int$i { devices = { d$i }; }" >> /tmp/ruleset.nft; done

I can't reproduce the bug you report here, you provide more detailed
description.
