Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3B77152A26
	for <lists+netfilter-devel@lfdr.de>; Wed,  5 Feb 2020 12:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgBELqI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 5 Feb 2020 06:46:08 -0500
Received: from mail1.tootai.net ([213.239.227.108]:51394 "EHLO
        mail1.tootai.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgBELqH (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 5 Feb 2020 06:46:07 -0500
Received: from mail1.tootai.net (localhost [127.0.0.1])
        by mail1.tootai.net (Postfix) with ESMTP id 9CF856082611
        for <netfilter-devel@vger.kernel.org>; Wed,  5 Feb 2020 12:46:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=tootai.net; s=mail;
        t=1580903166; bh=T8IU/fh9wJJiah9GgHqcNIFqHCbMpojq0VQugGyIkws=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=bo9uD3sJwNnHAnd/V2JuzGIC9oBWOPWT5m6BZKxdljjGYbVPbpcb4phTQeM9rdvF1
         HUGTFxqE3aahxnVrzLKyf39BvSCMw2tnpb6LNLeaz5/k9HnQdGvufUMzBFB8u/IVTP
         neh7J71SSYiGd3lg3YPjpHTdJ4upBpuVv6/BAhhY=
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on wwwmail9
X-Spam-Level: 
X-Spam-Status: No, score=-102.5 required=3.5 tests=ALL_TRUSTED,BAYES_00,
        T_DKIM_INVALID,USER_IN_WHITELIST autolearn=ham autolearn_force=no
        version=3.4.2
Received: from [192.168.10.24] (unknown [192.168.10.24])
        by mail1.tootai.net (Postfix) with ESMTPSA id 618B460048C1
        for <netfilter-devel@vger.kernel.org>; Wed,  5 Feb 2020 12:46:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=tootai.net; s=mail;
        t=1580903166; bh=T8IU/fh9wJJiah9GgHqcNIFqHCbMpojq0VQugGyIkws=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=bo9uD3sJwNnHAnd/V2JuzGIC9oBWOPWT5m6BZKxdljjGYbVPbpcb4phTQeM9rdvF1
         HUGTFxqE3aahxnVrzLKyf39BvSCMw2tnpb6LNLeaz5/k9HnQdGvufUMzBFB8u/IVTP
         neh7J71SSYiGd3lg3YPjpHTdJ4upBpuVv6/BAhhY=
Subject: Re: NFT - delete rules per interface
To:     Netfilter list <netfilter-devel@vger.kernel.org>
References: <1292e1cd-d593-b1a5-2850-3ae18bd54a6c@tootai.net>
 <20200205114111.GD26952@breakpoint.cc>
From:   Daniel <tech@tootai.net>
Message-ID: <a67030c8-02e6-b0e5-c4e3-0e4a5b2bfe8d@tootai.net>
Date:   Wed, 5 Feb 2020 12:46:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200205114111.GD26952@breakpoint.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr-FR
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


Le 05/02/2020 à 12:41, Florian Westphal a écrit :
> Daniel <tech@tootai.net> wrote:
>> Hello,
>>
>> is there an easy way to delete rules/set/maps/... for a specific interface ?
> Can you elaborate?  With exception of netdev interface, none of these
> are per interface.
Eg deleting all rules concerning one interface no matter in which 
set/map/table/.., are defined rules for this specific interface

-- 
Daniel
