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
  id 1696
  arrival_time 37678.96208639314
  lifetime 1606.8874957271055
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 8
    gpu 25
    rom 37
  ]
  node [
    id 1
    label "1"
    cpu 35
    gpu 47
    rom 14
  ]
  node [
    id 2
    label "2"
    cpu 16
    gpu 0
    rom 37
  ]
  node [
    id 3
    label "3"
    cpu 44
    gpu 41
    rom 39
  ]
  node [
    id 4
    label "4"
    cpu 33
    gpu 42
    rom 33
  ]
  node [
    id 5
    label "5"
    cpu 32
    gpu 10
    rom 30
  ]
  node [
    id 6
    label "6"
    cpu 31
    gpu 18
    rom 6
  ]
  node [
    id 7
    label "7"
    cpu 39
    gpu 45
    rom 35
  ]
  node [
    id 8
    label "8"
    cpu 50
    gpu 10
    rom 3
  ]
  node [
    id 9
    label "9"
    cpu 43
    gpu 36
    rom 7
  ]
  node [
    id 10
    label "10"
    cpu 23
    gpu 37
    rom 27
  ]
  node [
    id 11
    label "11"
    cpu 16
    gpu 37
    rom 41
  ]
  edge [
    source 0
    target 1
    bw 16
  ]
  edge [
    source 1
    target 2
    bw 21
  ]
  edge [
    source 2
    target 3
    bw 10
  ]
  edge [
    source 3
    target 4
    bw 2
  ]
  edge [
    source 4
    target 5
    bw 43
  ]
  edge [
    source 5
    target 6
    bw 39
  ]
  edge [
    source 6
    target 7
    bw 6
  ]
  edge [
    source 7
    target 8
    bw 20
  ]
  edge [
    source 8
    target 9
    bw 42
  ]
  edge [
    source 9
    target 10
    bw 4
  ]
  edge [
    source 10
    target 11
    bw 19
  ]
]
