Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61042447E1C
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Nov 2021 11:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238549AbhKHKk3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 8 Nov 2021 05:40:29 -0500
Received: from mail.netfilter.org ([217.70.188.207]:46896 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238365AbhKHKk1 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:40:27 -0500
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 1F13B606B2;
        Mon,  8 Nov 2021 11:35:45 +0100 (CET)
Date:   Mon, 8 Nov 2021 11:37:39 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florent Fourcot <florent.fourcot@wifirst.fr>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: ctnetlink: do not erase error code with
 EINVAL
Message-ID: <YYj986xSGwzq/RjX@salvia>
References: <20211103222155.17981-1-florent.fourcot@wifirst.fr>
 <20211103222155.17981-2-florent.fourcot@wifirst.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211103222155.17981-2-florent.fourcot@wifirst.fr>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Nov 03, 2021 at 11:21:55PM +0100, Florent Fourcot wrote:
> And be consistent in error management for both orig/reply filtering

Also applied.
