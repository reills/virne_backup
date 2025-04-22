graph [
  node_attrs_setting [
    name "cpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "gpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "rom"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  link_attrs_setting "_networkx_list_start"
  link_attrs_setting [
    name "bw"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "link"
    type "resource"
  ]
  id 58
  arrival_time 1215.738304071629
  lifetime 0.4724856199958078
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 13
    gpu 13
    rom 47
  ]
  node [
    id 1
    label "1"
    cpu 40
    gpu 20
    rom 34
  ]
  node [
    id 2
    label "2"
    cpu 19
    gpu 29
    rom 40
  ]
  node [
    id 3
    label "3"
    cpu 18
    gpu 46
    rom 31
  ]
  node [
    id 4
    label "4"
    cpu 34
    gpu 50
    rom 17
  ]
  node [
    id 5
    label "5"
    cpu 30
    gpu 35
    rom 47
  ]
  node [
    id 6
    label "6"
    cpu 39
    gpu 32
    rom 6
  ]
  node [
    id 7
    label "7"
    cpu 3
    gpu 37
    rom 12
  ]
  node [
    id 8
    label "8"
    cpu 50
    gpu 4
    rom 26
  ]
  node [
    id 9
    label "9"
    cpu 34
    gpu 32
    rom 43
  ]
  node [
    id 10
    label "10"
    cpu 49
    gpu 22
    rom 37
  ]
  edge [
    source 0
    target 1
    bw 9
  ]
  edge [
    source 1
    target 2
    bw 2
  ]
  edge [
    source 2
    target 3
    bw 41
  ]
  edge [
    source 3
    target 4
    bw 22
  ]
  edge [
    source 4
    target 5
    bw 31
  ]
  edge [
    source 5
    target 6
    bw 48
  ]
  edge [
    source 6
    target 7
    bw 36
  ]
  edge [
    source 7
    target 8
    bw 31
  ]
  edge [
    source 8
    target 9
    bw 25
  ]
  edge [
    source 9
    target 10
    bw 9
  ]
]
