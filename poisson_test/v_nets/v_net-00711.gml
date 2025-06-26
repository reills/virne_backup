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
  id 711
  arrival_time 14861.684933679771
  lifetime 992.2835660503407
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 33
    gpu 30
    rom 2
  ]
  node [
    id 1
    label "1"
    cpu 33
    gpu 20
    rom 26
  ]
  node [
    id 2
    label "2"
    cpu 49
    gpu 1
    rom 16
  ]
  node [
    id 3
    label "3"
    cpu 1
    gpu 12
    rom 49
  ]
  node [
    id 4
    label "4"
    cpu 49
    gpu 20
    rom 19
  ]
  node [
    id 5
    label "5"
    cpu 13
    gpu 42
    rom 6
  ]
  node [
    id 6
    label "6"
    cpu 18
    gpu 14
    rom 18
  ]
  node [
    id 7
    label "7"
    cpu 44
    gpu 17
    rom 9
  ]
  node [
    id 8
    label "8"
    cpu 7
    gpu 50
    rom 14
  ]
  node [
    id 9
    label "9"
    cpu 42
    gpu 22
    rom 15
  ]
  node [
    id 10
    label "10"
    cpu 44
    gpu 12
    rom 34
  ]
  edge [
    source 0
    target 1
    bw 13
  ]
  edge [
    source 1
    target 2
    bw 0
  ]
  edge [
    source 2
    target 3
    bw 35
  ]
  edge [
    source 3
    target 4
    bw 39
  ]
  edge [
    source 4
    target 5
    bw 6
  ]
  edge [
    source 5
    target 6
    bw 21
  ]
  edge [
    source 6
    target 7
    bw 42
  ]
  edge [
    source 7
    target 8
    bw 7
  ]
  edge [
    source 8
    target 9
    bw 3
  ]
  edge [
    source 9
    target 10
    bw 25
  ]
]
