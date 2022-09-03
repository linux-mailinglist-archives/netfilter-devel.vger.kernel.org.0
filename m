Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76B65ABE70
	for <lists+netfilter-devel@lfdr.de>; Sat,  3 Sep 2022 12:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiICKRv (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 3 Sep 2022 06:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiICKRu (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 3 Sep 2022 06:17:50 -0400
X-Greylist: delayed 431 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 03 Sep 2022 03:17:49 PDT
Received: from mail1.systemli.org (mail1.systemli.org [93.190.126.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705FB5A3FF
        for <netfilter-devel@vger.kernel.org>; Sat,  3 Sep 2022 03:17:49 -0700 (PDT)
Message-ID: <db95b6b2-ff01-c4ba-e3ea-8dd5f0fd8cf9@systemli.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=systemli.org;
        s=default; t=1662199835;
        bh=mcwhuAxHFUaloaXKe1GiBQR4dPzXylFuNtYXhNANj9I=;
        h=Date:To:From:Subject:From;
        b=JJFP4BVZiA281dqi8FqQE3f9GINKyLbYwtY0JhXrT5QfjGPYrSwYFDiT/qzV1bdBt
         Kv10NqxUYzfiKWtk5Mco8VHiFhBT0lhPC3+K/WDiq5wYe73AFkiBd9jnaZSWlhIpBq
         KGYnfeM32IxQ6/VqAVLJu5TkUTI5BJ8Sp6a02I81B67zlu3mecrp4gVIOZmxrKb/KT
         u7gmTL5z6+C0xpioovCqcfpswcqXbh4lLJZgPlh4juLBF1z8k35l1MaGhaKjRli1ua
         2JLrTVEMiqisJj3L71F8QZAi86GTCd8zjaREUECAjTqS4QQe2cwAS3rGyOB9lDwii7
         6fFd2xTl4Ctdg==
Date:   Sat, 3 Sep 2022 12:10:34 +0200
MIME-Version: 1.0
Content-Language: en-US
To:     Netfilter Development Mailing List 
        <netfilter-devel@vger.kernel.org>
From:   Nick <vincent@systemli.org>
Subject: CPE-ID?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,
I can not find any cpe-id for nftables? Typically, I query this 
database: https://nvd.nist.gov/vuln/search

Bests,
Nick

