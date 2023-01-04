Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1836A65D3BD
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Jan 2023 14:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjADNGC (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 4 Jan 2023 08:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239368AbjADNF5 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:05:57 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB0E13D56
        for <netfilter-devel@vger.kernel.org>; Wed,  4 Jan 2023 05:05:51 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id p12so16248870qkm.0
        for <netfilter-devel@vger.kernel.org>; Wed, 04 Jan 2023 05:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2m/uNsCm/OsAUZxAnJOSdXXDa9Gh4wg88n4VPL2lMU=;
        b=CvL+ep+/rtWoqemfxI7wMRAa6l5m75uCs0NkeX9c/LvgwQeBe2yteZ282qet7LqK3e
         HxG/Im0ZM/D1WODWOklWQLf7OSL2rnEYePbCC3kd5S7iXTIHk2TS9m4HXqg7X35SFalO
         la5iGs7bIa3/kTqN6sAmkNh0hoDLXQ/We3MdB2P1weN7ux+DF08kDg/6A/Y6YfgRBxcY
         KtDFS1uPETmKgl0qf8DjC302y7mP/AVrTIbIo86apj+J47m+1pZNy3GOJxen9dicVXiY
         BsuY33L2i2P2qgBdsZW4+/Yf2ArRdKBESHT+mFor1aYszrVEnphp0wzk59LkTEnCXMpY
         DxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g2m/uNsCm/OsAUZxAnJOSdXXDa9Gh4wg88n4VPL2lMU=;
        b=ARPsMHwgpoGPvPvJUtLTbUM9ipWM8z7pNsFIqM/0UXUX9E6tz+BXE8li5GzzYmGdjT
         rQg5eWvnHHqQz7RbvnBkC1EXZN/YhVoV9nsnbFQ9NlHp9px9UKCbTD0w9nLxaMwWs1F4
         c1yY/pOpUBC4MF0T+JG8UVKwm0LtGD6qAjIRjxJ4kFwB5Q2wbv1lgrJqVEfeoOYvGl3+
         VO02s0fTSNaLnS5GVI9tlp03CIE7ooSrH3Q6UtVmuvC9ri/AvnnJP//a9FTxxZYYrDUJ
         0iSCW9WiSmlDZLE5sAMI4xoXH6lWjXXpqiewvRfqQrW3dmsmWRqV9j5Q2CleM7gSvawM
         J2Ug==
X-Gm-Message-State: AFqh2kpprOr1gJB8RIMSijMkWUe3SkXHRUcOQmRbB8a0wDuy8X+pk4DS
        dHRFmw5dUpyW/h+4iriBA+5zSavFUS1W5y90Kjk=
X-Google-Smtp-Source: AMrXdXu2OgEBObdRdbMNu97JgXKPUIU/iPSgjknWbpkI9oHVVplu/0eITEKHSfy21FjM4TZO7YYYJ2NT+qIkDRPzmNA=
X-Received: by 2002:a05:620a:1327:b0:6ff:df2:2936 with SMTP id
 p7-20020a05620a132700b006ff0df22936mr1594016qkj.138.1672837550090; Wed, 04
 Jan 2023 05:05:50 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ad4:574b:0:b0:531:bf92:424d with HTTP; Wed, 4 Jan 2023
 05:05:49 -0800 (PST)
Reply-To: Gregdenzell9@gmail.com
From:   Greg Denzell <ketiaxbusux@gmail.com>
Date:   Wed, 4 Jan 2023 13:05:49 +0000
Message-ID: <CAMG0K-Sr6UEGeS3F8yMsn1s0JW0MpyFf3Mbwf-181tMy0XDkMg@mail.gmail.com>
Subject: Seasons Greetings!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Seasons Greetings!

This will remind you again that I have not yet received your reply to
my last message to you.
