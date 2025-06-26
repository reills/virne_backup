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
  id 1335
  arrival_time 28231.051900281924
  lifetime 2616.2588702086596
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 16
    gpu 17
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 49
    gpu 34
    rom 35
  ]
  node [
    id 2
    label "2"
    cpu 17
    gpu 6
    rom 15
  ]
  node [
    id 3
    label "3"
    cpu 4
    gpu 34
    rom 2
  ]
  node [
    id 4
    label "4"
    cpu 33
    gpu 43
    rom 41
  ]
  node [
    id 5
    label "5"
    cpu 12
    gpu 7
    rom 1
  ]
  node [
    id 6
    label "6"
    cpu 1
    gpu 25
    rom 25
  ]
  node [
    id 7
    label "7"
    cpu 7
    gpu 22
    rom 50
  ]
  node [
    id 8
    label "8"
    cpu 22
    gpu 42
    rom 15
  ]
  node [
    id 9
    label "9"
    cpu 14
    gpu 30
    rom 26
  ]
  node [
    id 10
    label "10"
    cpu 24
    gpu 1
    rom 22
  ]
  node [
    id 11
    label "11"
    cpu 24
    gpu 1
    rom 37
  ]
  node [
    id 12
    label "12"
    cpu 31
    gpu 14
    rom 2
  ]
  edge [
    source 0
    target 1
    bw 18
  ]
  edge [
    source 1
    target 2
    bw 7
  ]
  edge [
    source 2
    target 3
    bw 44
  ]
  edge [
    source 3
    target 4
    bw 13
  ]
  edge [
    source 4
    target 5
    bw 44
  ]
  edge [
    source 5
    target 6
    bw 6
  ]
  edge [
    source 6
    target 7
    bw 10
  ]
  edge [
    source 7
    target 8
    bw 0
  ]
  edge [
    source 8
    target 9
    bw 46
  ]
  edge [
    source 9
    target 10
    bw 28
  ]
  edge [
    source 10
    target 11
    bw 33
  ]
  edge [
    source 11
    target 12
    bw 46
  ]
]
