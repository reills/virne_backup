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
  id 675
  arrival_time 14359.371598534904
  lifetime 123.49149893142142
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 22
    gpu 36
    rom 3
  ]
  node [
    id 1
    label "1"
    cpu 39
    gpu 49
    rom 27
  ]
  node [
    id 2
    label "2"
    cpu 2
    gpu 43
    rom 29
  ]
  node [
    id 3
    label "3"
    cpu 46
    gpu 36
    rom 26
  ]
  node [
    id 4
    label "4"
    cpu 43
    gpu 24
    rom 30
  ]
  node [
    id 5
    label "5"
    cpu 50
    gpu 43
    rom 3
  ]
  node [
    id 6
    label "6"
    cpu 49
    gpu 40
    rom 31
  ]
  node [
    id 7
    label "7"
    cpu 46
    gpu 25
    rom 47
  ]
  node [
    id 8
    label "8"
    cpu 32
    gpu 46
    rom 24
  ]
  node [
    id 9
    label "9"
    cpu 30
    gpu 19
    rom 38
  ]
  node [
    id 10
    label "10"
    cpu 1
    gpu 35
    rom 45
  ]
  node [
    id 11
    label "11"
    cpu 35
    gpu 8
    rom 5
  ]
  edge [
    source 0
    target 1
    bw 12
  ]
  edge [
    source 1
    target 2
    bw 9
  ]
  edge [
    source 2
    target 3
    bw 31
  ]
  edge [
    source 3
    target 4
    bw 26
  ]
  edge [
    source 4
    target 5
    bw 46
  ]
  edge [
    source 5
    target 6
    bw 18
  ]
  edge [
    source 6
    target 7
    bw 7
  ]
  edge [
    source 7
    target 8
    bw 49
  ]
  edge [
    source 8
    target 9
    bw 24
  ]
  edge [
    source 9
    target 10
    bw 24
  ]
  edge [
    source 10
    target 11
    bw 21
  ]
]
