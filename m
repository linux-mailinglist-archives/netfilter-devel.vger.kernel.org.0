Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FEB46A680
	for <lists+netfilter-devel@lfdr.de>; Mon,  6 Dec 2021 21:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348802AbhLFUHE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 6 Dec 2021 15:07:04 -0500
Received: from mail.netfilter.org ([217.70.188.207]:35664 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245711AbhLFUHE (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 6 Dec 2021 15:07:04 -0500
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 31860605BC;
        Mon,  6 Dec 2021 21:01:13 +0100 (CET)
Date:   Mon, 6 Dec 2021 21:03:30 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft 0/3] typeof fixes
Message-ID: <Ya5skt4kJCD2Yxdh@salvia>
References: <20211203160755.8720-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211203160755.8720-1-fw@strlen.de>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Dec 03, 2021 at 05:07:52PM +0100, Florian Westphal wrote:
> First patch removes unused code fropm ipopt.
> Second patch adds missing udata support for tcp/ip options and sctp
> chunks.
> Third patch fixes a crash in nft describe.

LGTM, thanks
