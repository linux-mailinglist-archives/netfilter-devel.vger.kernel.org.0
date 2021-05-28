Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D60A394771
	for <lists+netfilter-devel@lfdr.de>; Fri, 28 May 2021 21:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbhE1TMI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 28 May 2021 15:12:08 -0400
Received: from mail.netfilter.org ([217.70.188.207]:58040 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhE1TMI (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 28 May 2021 15:12:08 -0400
Received: from netfilter.org (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 3995E644EE
        for <netfilter-devel@vger.kernel.org>; Fri, 28 May 2021 21:09:29 +0200 (CEST)
Date:   Fri, 28 May 2021 21:10:28 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: rebasing nf-next
Message-ID: <20210528191028.GA26767@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

There's currently a small conflict between nf-next and net-next,
specifically, the most recent pipapo fix for nf and the retpoline
updates for the set infrastructure.

I'm going to rebase the nf-next to send a simple pull request for
net-next.

So I'm rebase nf-next, please rebase any pending work in your
working copies too.

Sorry for the inconvenience.
