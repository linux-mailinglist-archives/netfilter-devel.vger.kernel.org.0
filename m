Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3CC043C62D
	for <lists+netfilter-devel@lfdr.de>; Wed, 27 Oct 2021 11:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240031AbhJ0JMm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 27 Oct 2021 05:12:42 -0400
Received: from mail.netfilter.org ([217.70.188.207]:47762 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239949AbhJ0JMl (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 27 Oct 2021 05:12:41 -0400
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 9AC5360098;
        Wed, 27 Oct 2021 11:08:28 +0200 (CEST)
Date:   Wed, 27 Oct 2021 11:10:13 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Chris Arges <carges@cloudflare.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] cache: ensure evaluate_cache_list flags are set
 correctly
Message-ID: <YXkXdSWFzXXn7nm6@salvia>
References: <4ffb3529-5f80-608b-497f-b0cb82a2dd3d@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ffb3529-5f80-608b-497f-b0cb82a2dd3d@cloudflare.com>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Oct 26, 2021 at 02:56:04PM -0500, Chris Arges wrote:
> This change ensures that when listing rulesets with the terse flag that the
> terse flag is maintained.

Applied
