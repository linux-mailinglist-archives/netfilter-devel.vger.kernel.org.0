Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45538597E6B
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Aug 2022 08:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243574AbiHRGLZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 18 Aug 2022 02:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243561AbiHRGLY (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 18 Aug 2022 02:11:24 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D678FD64
        for <netfilter-devel@vger.kernel.org>; Wed, 17 Aug 2022 23:11:23 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id fy5so1405897ejc.3
        for <netfilter-devel@vger.kernel.org>; Wed, 17 Aug 2022 23:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc;
        bh=kcf3o5XEy3Spgi736o8P093dNGs5kHqMxZj7oJ3pSsw=;
        b=Tx4Ycu0eXQVrVrvcrgrXjwwmtmY2Z3hbFrZsffiNngJOK+XDwh0cl/qtjnDhiGL81Q
         OibB1V4dtEk7tU5PV5WvElB7AiQnoAUolWWVBWMVJ2tNCgnaMQWwJ5mDdlBk6AC2zgQ4
         e8pPRM71As/4/Abyec+1Y8PVIcUwos3vCnl5XlOOFs9+Q9deO8qi96azIozC+X02ayWP
         pdRB2vZ7nN+Tey8vka4asa3zUHjKVyJCmkEQ9do7mvFhR3wDzH9xYOtTzyqMH8olvAV6
         gzVKoNY8SrC7jjI9PcVZxG3h17wp1Un+Pcl3az2QitlPv0knsAfcjSUVeFZQqRWBpfU8
         35JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=kcf3o5XEy3Spgi736o8P093dNGs5kHqMxZj7oJ3pSsw=;
        b=USzAGC1Y5nYZVXwqL3rRtNslkJxm14pHc+7SwWLTYZ5VNpoLWs/BZNvs5mKYlA7k4D
         8U2eG3suIRvHsOvkJBRbsrAi4t6KZLpK6A0+pHP5lZp6rZeC8eEoF2cUX8k6PGlE1fL9
         TSsGOxVQ3b6S9ZxMprPb25A04ChxrH0iKx1PKB8dIt7vosl9PY3xqKpaaIyuE2kAzWhG
         Y+fBoESxoZzFWrk44Uz7JY1yKMOnGrdilc+VE0BOYZvBpLCoSb0mHnoKA5lOuoXvezbm
         1RuuNvahuJywp+0/8oMZDqfYwf/4770gqECQnU/Ub97BAPyn505Jw1UOtSV19JZxSmlH
         oBOg==
X-Gm-Message-State: ACgBeo31NvWyYiIWFiLH0KoLoqyFmORWTpOXvVR0J+iVnb1xtvXE84WF
        2s81riYq2Ybu8rJ5t6mEG8NQrhWQ0dzKrgOt4oA=
X-Google-Smtp-Source: AA6agR5lCtc6hXnyNEJE78ATAbXd+lvOiAH1SEPKAL5dtixN6XgcMSmsaGvLxU1FRYPlUa9nlYwZQLGEAfYQZqitELU=
X-Received: by 2002:a17:906:4795:b0:733:1d3:3d33 with SMTP id
 cw21-20020a170906479500b0073301d33d33mr982586ejc.200.1660803081775; Wed, 17
 Aug 2022 23:11:21 -0700 (PDT)
MIME-Version: 1.0
Reply-To: pmrsnancy@gmail.com
Sender: miss.douglasegobia19@gmail.com
Received: by 2002:a17:906:9c93:0:0:0:0 with HTTP; Wed, 17 Aug 2022 23:11:21
 -0700 (PDT)
From:   "Mrs. Nancy Peters" <mrsnancypeters4@gmail.com>
Date:   Wed, 17 Aug 2022 23:11:21 -0700
X-Google-Sender-Auth: Yifh-wh0XDS4mIJjQ3tgHpN3Lvg
Message-ID: <CABkf4qUMBOTgtJV94vSPS8RxifVfJ9QqX-eqDG0-1VXh45osRg@mail.gmail.com>
Subject: RE: URGENT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

-- 
An email was sent to you sometime last week with the expectation of
receiving a return email from you, but to my surprise, you never
bothered to reply. Please reply for further explanation.
